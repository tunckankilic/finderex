import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButtonOptions {
  const CustomButtonOptions({
    this.textStyle,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.disabledColor,
    this.disabledTextColor,
    this.splashColor,
    this.highlightColor,
    this.iconSize,
    this.iconColor,
    this.iconPadding,
    this.borderRadius,
    this.borderSide,
    this.borderRadiusCustom,
  });

  final TextStyle? textStyle;
  final double? elevation;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Color? splashColor;
  final Color? highlightColor;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final double? borderRadius;
  final BorderSide? borderSide;
  final BorderRadius? borderRadiusCustom;
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.child,
    this.text,
    required this.onPressed,
    this.icon,
    this.iconData,
    required this.options,
  }) : super(key: key);

  final String? text;
  final Widget? child, icon;
  final IconData? iconData;
  final VoidCallback onPressed;
  final CustomButtonOptions options;

  @override
  Widget build(BuildContext context) {
    var textWidget;
    if (child != null) {
      textWidget = child;
    } else if (text != null) {
      textWidget = AutoSizeText(
        text!,
        style: options.textStyle,
        maxLines: 1,
      );
    }
    if (icon != null || iconData != null) {
      return SizedBox(
        height: options.height,
        width: options.width,
        child: ElevatedButton.icon(
          icon: Padding(
            padding: options.iconPadding ?? EdgeInsets.zero,
            child: icon ??
                FaIcon(
                  iconData,
                  size: options.iconSize,
                  color: options.iconColor ??
                      options.textStyle!.color ??
                      Colors.white,
                ),
          ),
          label: textWidget,
          onPressed: onPressed,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: options.borderRadiusCustom ??
                  BorderRadius.circular(options.borderRadius ?? 0),
              side: options.borderSide ?? BorderSide.none,
            )),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return options.disabledColor;
              }

              return options.color ?? Colors.white;
            }),
            elevation: MaterialStateProperty.all(options.elevation),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return options.disabledTextColor;
              }

              return options.textStyle!.color ?? Colors.white;
            }),
            overlayColor: MaterialStateProperty.all(options.highlightColor),

            // colorBrightness: ThemeData.estimateBrightnessForColor(
            //     options.color ?? Colors.white),
            // splashColor: options.splashColor,
          ),
        ),
      );
    }

    return SizedBox(
      height: options.height,
      width: options.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: options.borderRadiusCustom ??
                  BorderRadius.circular(options.borderRadius ?? 28),
              side: options.borderSide ?? BorderSide.none,
            )),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return options.disabledColor;
              }

              return options.color ?? Colors.white;
            }),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return options.disabledTextColor;
              }

              return options.textStyle!.color ?? Colors.white;
            }),
            overlayColor: MaterialStateProperty.all(options.highlightColor),
            // splashColor: options.splashColor,
            // colorBrightness: ThemeData.estimateBrightnessForColor(
            //     options.color ?? Colors.white),
            padding: MaterialStateProperty.all(options.padding),
            elevation: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.pressed)) {
                return options.splashColor != null ? 0 : null;
              }

              return options.elevation;
            })),
        child: textWidget,
      ),
    );
  }
}
