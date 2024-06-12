import 'package:dchat/config/constants/image_addresses.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

enum ImageType { network, file, asset, memory }

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
    required this.source,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.height,
    this.width,
    this.alignment = Alignment.center,
  });

  final String source;

  final BoxFit fit;
  final Widget? placeholder;
  final double? height;
  final double? width;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final localHeight = height ?? double.infinity;
    final localWidth = width ?? double.infinity;
    return ExtendedImage.asset(
      source,
      fit: fit,
      alignment: alignment,
      height: localHeight,
      width: localWidth,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return placeholder ?? Container(color: Colors.white);

          case LoadState.completed:
            return ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              fit: fit,
              height: localHeight,
              width: localWidth,
            );
          case LoadState.failed:
            return ExtendedImage.asset(
              ImageAddresses.imagePlaceholder,
              height: localHeight,
              width: localWidth,
            );
        }
      },
    );
  }
}
