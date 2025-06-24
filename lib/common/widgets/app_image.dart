import 'dart:io';
import 'dart:typed_data';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app_shimmer.dart';

class AppImage extends StatelessWidget {
  final dynamic image; // this can be string or file
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AppImage(this.image, {super.key, this.width, this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    if (image is File) {
      return Image.file(image, width: width, height: height, fit: fit);
    }
    if (image is Uint8List) {
      return Image.memory(image, width: width, height: height, fit: fit);
    }

    if (image is String == false) {
      return AppImageError(
        width: width,
        height: height,
        error: 'Invalid image type: ${image.runtimeType}',
      );
    }

    if ((image ?? '').isEmpty) {
      return AppImageError(
        width: width,
        height: height,
        error: 'Image is empty',
      );
    }

    if (image.startsWith('assets/')) {
      return Image.asset(image, width: width, height: height, fit: fit);
    }

    return CachedNetworkImage(
      imageUrl: image,
      width: width,
      height: height,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return AppImageLoading(
          width: width,
          height: height,
          progress: downloadProgress.progress,
        );
      },
      errorWidget: (context, url, error) =>
          AppImageError(width: width, height: height, error: '$error'),
    );
  }
}

class AppImageLoading extends StatelessWidget {
  final double? width;
  final double? height;
  final double? progress;

  const AppImageLoading({super.key, this.width, this.height, this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          AppShimmer(
            child: Container(width: width, height: height, color: Colors.white),
          ),

          if (progress != null && progress! >= 0.0)
            Center(
              child: CircularProgressIndicator(
                value: progress,
                color: Colors.grey[300],
                strokeWidth: 3,
              ),
            ),

          if (progress != null && progress! >= 0.0)
            Center(
              child: AnimatedFlipCounter(
                value: progress! * 100,
                fractionDigits: 0,
                suffix: "%",
                textStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AppImageError extends StatelessWidget {
  final double? width;
  final double? height;
  final String? error;

  const AppImageError({super.key, this.width, this.height, this.error});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Column(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.broken_image_outlined,
              size: 40,
              color: Colors.grey[400],
            ),
            if (error != null)
              Text(
                error!,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }
}
