#!/bin/sh
# Runs add_live_activity_target.rb against the xcodeproj gem that ships
# inside Homebrew's CocoaPods, so there's nothing extra to install: any
# machine that can `pod install` for this project already has it.
set -e

POD_PATH=$(command -v pod) || {
    echo "CocoaPods not found. Install it, or: gem install xcodeproj" >&2
    exit 1
}
# Resolve the Homebrew shim to the real Cellar path, whose sibling libexec/
# holds the bundled gems. Ruby's realpath rather than readlink, which on
# macOS reports the link's own relative target instead of following it.
POD_PATH=$(ruby -e 'puts File.realpath(ARGV[0])' "$POD_PATH")
COCOAPODS_LIBEXEC="$(dirname "$(dirname "$POD_PATH")")/libexec"

if [ ! -d "$COCOAPODS_LIBEXEC/gems" ]; then
    echo "No bundled gems under $COCOAPODS_LIBEXEC." >&2
    echo "Try: gem install xcodeproj" >&2
    exit 1
fi

JWS_GEM_LOAD_PATH=$(ls -d "$COCOAPODS_LIBEXEC"/gems/*/lib | tr '\n' ':' | sed 's/:$//')
export JWS_GEM_LOAD_PATH

exec ruby -e '
$LOAD_PATH.unshift(*ENV["JWS_GEM_LOAD_PATH"].split(":"))
load ARGV[0]
' "$(dirname "$0")/add_live_activity_target.rb"
