import 'dart:io' show Platform;

import 'package:flutter/services.dart';

/// [name] and [author] are deliberately NOT localized: artists are credited identically in every language
class AppIconOption {
  const AppIconOption({
    required this.id,
    required this.name,
    required this.previewAsset,
    required this.androidAlias,
    required this.iosAlternateName,
    this.author,
  });

  /// Stable id, also what a platform reports as the active icon.
  final String id;
  final String name;
  final String? author;
  final String previewAsset;

  /// The activity-alias suffix in AndroidManifest.xml (null on the platform side means "don't offer switching there").
  final String? androidAlias;

  /// The alternate icon name in the iOS asset catalog.
  final String? iosAlternateName;
}

const List<AppIconOption> kAppIconOptions = <AppIconOption>[
  AppIconOption(
    id: 'default',
    name: 'Classic',
    author: 'Official',
    previewAsset: 'assets/icon_onboarding.png',
    androidAlias: 'MainActivityDefault',
    iosAlternateName: null, // no name = the primary icon on iOS
  ),
  AppIconOption(
    id: 'globalLove',
    name: 'Global Love',
    author: 'Sachtzart',
    previewAsset: 'assets/icon_global_love.png',
    androidAlias: 'MainActivityGlobalLove',
    iosAlternateName: 'AppIcon-GlobalLove',
  ),
  AppIconOption(
    id: 'alpine',
    name: 'Alpine',
    author: 'Official',
    previewAsset: 'assets/icon_alpine.png',
    androidAlias: 'MainActivityAlpine',
    iosAlternateName: 'AppIcon-Alpine',
  ),
  AppIconOption(
    id: 'minimalist',
    name: 'Minimalist',
    author: 'Official',
    previewAsset: 'assets/icon_minimalist.png',
    androidAlias: 'MainActivityMinimalist',
    iosAlternateName: 'AppIcon-Minimalist',
  ),
  AppIconOption(
    id: 'modern',
    name: 'Modern',
    author: 'Official',
    previewAsset: 'assets/icon_modern.png',
    androidAlias: 'MainActivityModern',
    iosAlternateName: 'AppIcon-Modern',
  ),
  AppIconOption(
    id: 'smallHand',
    name: 'Small Hand',
    author: 'Official',
    previewAsset: 'assets/icon_small_hand.png',
    androidAlias: 'MainActivitySmallHand',
    iosAlternateName: 'AppIcon-SmallHand',
  ),
  AppIconOption(
    id: 'whiteLake',
    name: 'White Lake',
    author: 'Official',
    previewAsset: 'assets/icon_white_lake.png',
    androidAlias: 'MainActivityWhiteLake',
    iosAlternateName: 'AppIcon-WhiteLake',
  ),
];

class AppIconService {
  static const MethodChannel _channel = MethodChannel(
    'com.jwstreak.app/app_icon',
  );

  /// The id of the icon the system currently shows
  Future<String> getCurrentId() async {
    if (Platform.isAndroid) {
      final String? alias = await _channel.invokeMethod<String>(
        'getCurrent',
        <String, Object>{
          'aliases': <String>[
            for (final AppIconOption icon in kAppIconOptions)
              if (icon.androidAlias != null) icon.androidAlias!,
          ],
        },
      );
      if (alias != null) {
        for (final AppIconOption icon in kAppIconOptions) {
          if (icon.androidAlias == alias) {
            return icon.id;
          }
        }
      }
      return kAppIconOptions.first.id;
    }
    if (Platform.isIOS) {
      final String? name = await _channel.invokeMethod<String>('getCurrent');
      if (name == null || name.isEmpty) {
        return kAppIconOptions.first.id;
      }
      for (final AppIconOption icon in kAppIconOptions) {
        if (icon.iosAlternateName == name) {
          return icon.id;
        }
      }
      return kAppIconOptions.first.id;
    }
    return kAppIconOptions.first.id;
  }

  /// Switches the launcher icon; resolves to the id the platform now shows
  /// (the switch can fail on iOS, where iOS itself shows a confirm prompt).
  Future<String> requestIcon(String id) async {
    final AppIconOption target = _optionById(id);
    if (Platform.isAndroid && target.androidAlias != null) {
      await _channel.invokeMethod<String>('set', <String, Object>{
        'aliases': <String>[
          for (final AppIconOption icon in kAppIconOptions)
            if (icon.androidAlias != null) icon.androidAlias!,
        ],
        'alias': target.androidAlias!,
      });
      return target.id;
    }
    if (Platform.isIOS && target.iosAlternateName != null) {
      await _channel.invokeMethod<String>('set', <String, Object>{
        'name': target.iosAlternateName!,
      });
      return target.id;
    }
    return await getCurrentId();
  }

  AppIconOption _optionById(String id) => kAppIconOptions.firstWhere(
    (AppIconOption icon) => icon.id == id,
    orElse: () => kAppIconOptions.first,
  );
}
