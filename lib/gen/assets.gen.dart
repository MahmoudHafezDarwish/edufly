/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $IconsGen {
  const $IconsGen();

  /// File path: icons/Documents.svg
  String get documents => 'icons/Documents.svg';

  /// File path: icons/Figma_file.svg
  String get figmaFile => 'icons/Figma_file.svg';

  /// File path: icons/Search.svg
  String get search => 'icons/Search.svg';

  /// File path: icons/doc_file.svg
  String get docFile => 'icons/doc_file.svg';

  /// File path: icons/drop_box.svg
  String get dropBox => 'icons/drop_box.svg';

  /// File path: icons/excle_file.svg
  String get excleFile => 'icons/excle_file.svg';

  /// File path: icons/folder.svg
  String get folder => 'icons/folder.svg';

  /// File path: icons/google_drive.svg
  String get googleDrive => 'icons/google_drive.svg';

  /// File path: icons/logo.svg
  String get logo => 'icons/logo.svg';

  /// File path: icons/media.svg
  String get media => 'icons/media.svg';

  /// File path: icons/media_file.svg
  String get mediaFile => 'icons/media_file.svg';

  /// File path: icons/menu_dashbord.svg
  String get menuDashbord => 'icons/menu_dashbord.svg';

  /// File path: icons/menu_doc.svg
  String get menuDoc => 'icons/menu_doc.svg';

  /// File path: icons/menu_notification.svg
  String get menuNotification => 'icons/menu_notification.svg';

  /// File path: icons/menu_profile.svg
  String get menuProfile => 'icons/menu_profile.svg';

  /// File path: icons/menu_setting.svg
  String get menuSetting => 'icons/menu_setting.svg';

  /// File path: icons/menu_store.svg
  String get menuStore => 'icons/menu_store.svg';

  /// File path: icons/menu_task.svg
  String get menuTask => 'icons/menu_task.svg';

  /// File path: icons/menu_tran.svg
  String get menuTran => 'icons/menu_tran.svg';

  /// File path: icons/one_drive.svg
  String get oneDrive => 'icons/one_drive.svg';

  /// File path: icons/pdf_file.svg
  String get pdfFile => 'icons/pdf_file.svg';

  /// File path: icons/sound_file.svg
  String get soundFile => 'icons/sound_file.svg';

  /// File path: icons/unknown.svg
  String get unknown => 'icons/unknown.svg';

  /// File path: icons/xd_file.svg
  String get xdFile => 'icons/xd_file.svg';
}

class $ImagesGen {
  const $ImagesGen();

  /// File path: images/Bg.png
  AssetGenImage get bg => const AssetGenImage('images/Bg.png');

  /// File path: images/activeOrder.png
  AssetGenImage get activeOrder =>
      const AssetGenImage('images/activeOrder.png');

  /// File path: images/app_logo.png
  AssetGenImage get appLogo => const AssetGenImage('images/app_logo.png');

  /// File path: images/cat1.png
  AssetGenImage get cat1 => const AssetGenImage('images/cat1.png');

  /// File path: images/cat2.png
  AssetGenImage get cat2 => const AssetGenImage('images/cat2.png');

  /// File path: images/cat3.png
  AssetGenImage get cat3 => const AssetGenImage('images/cat3.png');

  /// File path: images/cat4.png
  AssetGenImage get cat4 => const AssetGenImage('images/cat4.png');

  /// File path: images/empty-box.png
  AssetGenImage get emptyBox => const AssetGenImage('images/empty-box.png');

  /// File path: images/feedbackImage.png
  AssetGenImage get feedbackImage =>
      const AssetGenImage('images/feedbackImage.png');

  /// File path: images/filtter.png
  AssetGenImage get filtter => const AssetGenImage('images/filtter.png');

  /// File path: images/order.png
  AssetGenImage get order => const AssetGenImage('images/order.png');

  /// File path: images/out1.png
  AssetGenImage get out1 => const AssetGenImage('images/out1.png');

  /// File path: images/out2.png
  AssetGenImage get out2 => const AssetGenImage('images/out2.png');

  /// File path: images/out3.png
  AssetGenImage get out3 => const AssetGenImage('images/out3.png');

  /// File path: images/placeholder.png
  AssetGenImage get placeholder =>
      const AssetGenImage('images/placeholder.png');

  /// File path: images/study.png
  AssetGenImage get study => const AssetGenImage('images/study.png');

  /// File path: images/success_pay_image.png
  AssetGenImage get successPayImage =>
      const AssetGenImage('images/success_pay_image.png');
}

class Assets {
  Assets._();

  static const $IconsGen icons = $IconsGen();
  static const $ImagesGen images = $ImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
