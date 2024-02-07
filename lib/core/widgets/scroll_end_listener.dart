import 'package:flutter/material.dart';

class ScrollEndListener extends StatelessWidget {
  final Widget child;
  final Function()? onScrollEnd;
  const ScrollEndListener({Key? key, this.onScrollEnd, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (!notification.metrics.atEdge || notification.metrics.pixels == 0)
          return true;

        onScrollEnd?.call();

        return true;
      },
      child: child,
    );
  }
}
