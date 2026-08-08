# Adds the ReadingSessionWidget app-extension target to ios/Runner.xcodeproj.
#
# The extension is what draws the reading-session Live Activity; the app
# target only starts and ends it (ios/Runner/ReadingSessionController.swift).
# An extension can't be declared in source alone — it's a second target with
# its own product, build settings and signing — so this script stands in for
# the Xcode "New Target" wizard, and keeps that setup reviewable in git
# instead of living only inside a binary-ish project file.
#
# Idempotent: running it again when the target already exists is a no-op.
#
# Run with:
#   tool/ios/add_live_activity_target.sh

require 'xcodeproj'

ROOT = File.expand_path('../..', __dir__)
PROJECT_PATH = File.join(ROOT, 'ios', 'Runner.xcodeproj')
TARGET_NAME = 'ReadingSessionWidget'
# Live Activities need 16.1, but ActivityConfiguration settled into its
# current shape in 16.2 — the app target itself stays on its own, lower
# deployment target.
DEPLOYMENT_TARGET = '16.2'

project = Xcodeproj::Project.open(PROJECT_PATH)
runner = project.targets.find { |t| t.name == 'Runner' }
raise 'Runner target not found' if runner.nil?

if project.targets.any? { |t| t.name == TARGET_NAME }
  puts "#{TARGET_NAME} already exists — nothing to do."
  exit 0
end

extension_target = project.new_target(
  :app_extension,
  TARGET_NAME,
  :ios,
  DEPLOYMENT_TARGET,
  nil,
  :swift
)

# Flutter writes FLUTTER_BUILD_NAME / FLUTTER_BUILD_NUMBER into
# Generated.xcconfig, which the two xcconfigs below include. The extension's
# Info.plist reads those same variables, and iOS rejects an extension whose
# version doesn't match its host app — so it has to inherit the same source
# of truth rather than hardcode anything.
xcconfigs = {}
project.files.each do |file|
  xcconfigs[File.basename(file.path.to_s)] = file if file.path.to_s.end_with?('.xcconfig')
end

extension_target.build_configurations.each do |config|
  base = config.name == 'Debug' ? xcconfigs['Debug.xcconfig'] : xcconfigs['Release.xcconfig']
  config.base_configuration_reference = base if base

  settings = config.build_settings
  settings['PRODUCT_BUNDLE_IDENTIFIER'] = "com.jwstreak.app.#{TARGET_NAME}"
  settings['INFOPLIST_FILE'] = "#{TARGET_NAME}/Info.plist"
  settings['IPHONEOS_DEPLOYMENT_TARGET'] = DEPLOYMENT_TARGET
  settings['SWIFT_VERSION'] = '5.0'
  settings['TARGETED_DEVICE_FAMILY'] = '1,2'
  settings['CODE_SIGN_STYLE'] = 'Automatic'
  settings['DEVELOPMENT_TEAM'] = 'BSA8Y2C9LB'
  # An extension ships inside its host app, never on its own.
  settings['SKIP_INSTALL'] = 'YES'
  settings['GENERATE_INFOPLIST_FILE'] = 'NO'
  settings['CURRENT_PROJECT_VERSION'] = '$(FLUTTER_BUILD_NUMBER)'
  settings['MARKETING_VERSION'] = '$(FLUTTER_BUILD_NAME)'
  # Inherited from the xcconfig, these would point at the app's own product.
  settings['PRODUCT_NAME'] = '$(TARGET_NAME)'
end

# Source files. The attributes file is deliberately in both targets: the app
# constructs the activity, the extension renders it, and they have to agree
# on the exact same type.
group = project.main_group.find_subpath(TARGET_NAME, true)
group.set_source_tree('SOURCE_ROOT')
group.set_path(TARGET_NAME)

shared_attributes = group.new_reference('ReadingSessionAttributes.swift')
extension_only = %w[
  ReadingSessionLiveActivity.swift
  ReadingSessionWidgetBundle.swift
].map { |name| group.new_reference(name) }
group.new_reference('Info.plist')

extension_target.add_file_references([shared_attributes] + extension_only)
runner.add_file_references([shared_attributes])

# The controller lives with the rest of the app's Swift.
runner_group = project.main_group.find_subpath('Runner', true)
controller = runner_group.new_reference('ReadingSessionController.swift')
runner.add_file_references([controller])

# What actually ships the extension inside the app bundle, plus the build
# ordering that guarantees it exists by the time it's copied.
embed_phase = runner.new_copy_files_build_phase('Embed App Extensions')
embed_phase.symbol_dst_subfolder_spec = :plug_ins
build_file = embed_phase.add_file_reference(extension_target.product_reference)
build_file.settings = { 'ATTRIBUTES' => ['RemoveHeadersOnCopy'] }
runner.add_dependency(extension_target)

# new_copy_files_build_phase appends, which lands the phase after Flutter's
# "Thin Binary" script. That script rewrites the built app bundle, so copying
# the extension in afterwards makes the two circular and Xcode refuses the
# build outright. Embedding has to happen before it runs.
thin_binary_index = runner.build_phases.index do |phase|
  phase.respond_to?(:name) && phase.name == 'Thin Binary'
end
unless thin_binary_index.nil?
  runner.build_phases.delete(embed_phase)
  runner.build_phases.insert(thin_binary_index, embed_phase)
end

project.save
puts "Added #{TARGET_NAME} (#{extension_target.build_configurations.map(&:name).join(', ')})."
