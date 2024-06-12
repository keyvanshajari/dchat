import 'package:dchat/widgets/image_viewer/image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgViewer extends StatelessWidget {
  const SvgViewer({
    super.key,
    required this.source,
    this.size,
    this.matchTextDirection = false,
    this.color,
    required this.imageType,
    this.semanticLabel,
    this.fit = BoxFit.cover,
  });

  final String source;
  final double? size;
  final bool matchTextDirection;
  final Color? color;
  final ImageType imageType;
  final BoxFit fit;
  final String? semanticLabel;

  const SvgViewer.asset(
    String assetName, {
    super.key,
    this.size,
    this.matchTextDirection = false,
    this.color,
    this.fit = BoxFit.cover,
    this.semanticLabel,
  })  : source = assetName,
        imageType = ImageType.asset;

  const SvgViewer.network(
    String url, {
    super.key,
    this.size,
    this.matchTextDirection = false,
    this.color,
    this.semanticLabel,
    this.fit = BoxFit.cover,
  })  : source = url,
        imageType = ImageType.network;

  @override
  Widget build(BuildContext context) {
    return imageType == ImageType.asset
        ? SvgPicture.asset(
            source,
            height: size,
            width: size,
            matchTextDirection: matchTextDirection,
            color: color,
            fit: fit,
            semanticsLabel: semanticLabel,
          )
        : SvgPicture.network(
            source,
            height: size,
            width: size,
            matchTextDirection: matchTextDirection,
            color: color,
            fit: fit,
            cacheColorFilter: true,
          );
  }
}
