import 'package:flutter/material.dart';

import 'category_column.dart';
import 'theme_chip.dart';

class ChipCategory extends StatelessWidget {
  final String title;
  final List<ThemeChip> chips;
  final TextStyle? titleStyle;
  const ChipCategory({
    Key? key,
    required this.title,
    required this.chips,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoryColumn(
      title: title,
      titleStyle: titleStyle,
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          ...chips,
        ],
      ),
    );
  }
}
