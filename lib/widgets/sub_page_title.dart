import 'package:flutter/material.dart';

class SubPageTitle extends StatelessWidget {
  final Widget? rightWidget;
  final Widget title;
  final Widget leftWidget;
  final EdgeInsets padding;
  const SubPageTitle({
    Key? key,
    required this.leftWidget,
    required this.title,
    this.rightWidget,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leftWidget,
          title,
          rightWidget ?? Container(),
        ],
      ),
    );
  }
}
