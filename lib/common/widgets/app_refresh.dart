import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppRefresh extends StatelessWidget {
  final RefreshController controller;
  final Widget? child;
  final WaterDropHeader? header;
  final ScrollPhysics? physics;
  final bool enabledRefresh;
  final bool enabledNext;
  final Function()? onNext;
  final Function()? onRefresh;

  const AppRefresh({
    super.key,
    required this.controller,
    this.child,
    this.header,
    this.physics,
    this.enabledRefresh = true,
    this.enabledNext = false,
    this.onRefresh,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      physics: physics ?? const ClampingScrollPhysics(),
      header:
          header ??
          const WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.grey),
            refresh: CupertinoActivityIndicator(color: Colors.grey),
            failed: Icon(Icons.close, color: Colors.grey),
          ),
      enablePullDown: enabledRefresh,
      enablePullUp: enabledNext,
      onRefresh: onRefresh,
      onLoading: onNext,
      child: child,
    );
  }
}
