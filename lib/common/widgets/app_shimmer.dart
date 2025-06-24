import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final Color? baseColor;
  final Color? highlightColor;

  const AppShimmer({
    super.key,
    required this.child,
    this.enabled = true,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    if (enabled) {
      return Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey[200]!,
        highlightColor: highlightColor ?? Colors.white,
        child: child,
      );
    }
    return child;
  }
}
