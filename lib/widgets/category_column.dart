import 'package:finderex/common/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CategoryColumn extends StatelessWidget {
  final String title;
  final Widget child;
  final TextStyle? titleStyle;
  const CategoryColumn({
    Key? key,
    required this.title,
    required this.child,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: context.paddingLowBottom,
          child: Text(
            title,
            style: titleStyle ??
                context.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[700],
                ),
          ),
        ),
        child,
      ],
    );
  }
}
