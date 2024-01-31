import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'custom_button.dart';

class ConfirmButton extends StatelessWidget {
  final Function() onClick;
  final String text;
  final double? width, height;
  final EdgeInsets? margin;

  const ConfirmButton({
    Key? key,
    required this.onClick,
    required this.text,
    this.width,
    this.height,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(5.w),
      child: CustomButton(
        onPressed: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          FocusScope.of(context).unfocus();
          onClick();
        },
        text: text,
        options: CustomButtonOptions(
          color: const Color.fromARGB(255, 63, 118, 212),
          width: width ?? 230.w,
          height: height ?? 50.h,
          textStyle: context.textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          elevation: 3,
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: 8,
        ),
      ),
    );
  }
}
