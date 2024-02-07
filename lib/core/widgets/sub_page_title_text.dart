import 'package:flutter/material.dart';

class SubPageTitleText extends StatelessWidget {
  final String text;
  final bool isTextSizeLarge;
  const SubPageTitleText(
    this.text, {
    Key? key,
    this.isTextSizeLarge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.grey[900],
      ),

      /*isTextSizeLarge
          ? context.textTheme.bodyLarge
          : context.textTheme.bodyMedium,*/
      maxLines: 1,
      overflow: TextOverflow.clip,
    );
  }
}
