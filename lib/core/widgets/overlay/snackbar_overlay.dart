import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_overlay.dart';

class SnackbarOverlayTop extends CustomOverlay with _SnackbarOverlay {}

class SnackbarOverlay extends CustomOverlay with _SnackbarOverlay {}

mixin _SnackbarOverlay on CustomOverlay {
  void show({
    bool addFrameCallback = false,
    bool forceOverlay = false,
    bool fullTap = false,
    Function()? onTap,
    required String text,
    required String buttonText,
    Color? buttonTextColor,
    Duration? removeDuration = const Duration(seconds: 2),
  }) {
    if (forceOverlay) closeCustomOverlay();
    showCustomOverlay(
        addFrameCallback: addFrameCallback,
        onTap: onTap,
        params: [text, buttonText, buttonTextColor, removeDuration, fullTap]);
  }

  @override
  Widget customOverlayWidget(ValueNotifier<OverlayEntry?> overlayEntry,
      {Function()? onTap, List<dynamic>? params}) {
    return SnackbarWidget(
      closeOverlay: closeCustomOverlay,
      overlayEntry: overlayEntry,
      onTap: onTap,
      text: params![0],
      buttonText: params[1],
      buttonTextColor: params[2],
      removeDuration: params[3],
      fullTap: params[4],
    );
  }
}

class SnackbarWidget extends StatefulWidget {
  final Function() closeOverlay;
  final Function()? onTap;
  final ValueNotifier<OverlayEntry?> overlayEntry;
  final String text;
  final String buttonText;
  final Color? buttonTextColor;
  final Duration? removeDuration;
  final bool fullTap;
  const SnackbarWidget({
    super.key,
    required this.overlayEntry,
    required this.onTap,
    required this.text,
    required this.buttonText,
    required this.closeOverlay,
    this.buttonTextColor,
    this.removeDuration,
    this.fullTap = false,
  });

  @override
  State<SnackbarWidget> createState() => _SnackbarWidgetState();
}

class _SnackbarWidgetState extends State<SnackbarWidget> {
  late double _opacity;
  late Duration animationDuration;
  @override
  void initState() {
    _opacity = 1.0;
    animationDuration = const Duration(milliseconds: 300);
    if (widget.removeDuration != null) removeTimer();
    super.initState();
  }

  void removeTimer() {
    Future.delayed(widget.removeDuration! - animationDuration, () {
      if (mounted) {
        setState(() {
          _opacity = 0.0;
        });
      }
      Future.delayed(animationDuration, () {
        if (mounted) widget.closeOverlay();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: animationDuration,
      opacity: _opacity,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              if (widget.fullTap && widget.onTap != null) {
                widget.onTap!();
              } else {
                SnackbarOverlayTop().closeCustomOverlay();
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: kBottomNavigationBarHeight),
              child: Material(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(5),
                elevation: 5.0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 7.5),
                        child: Text(
                          widget.text,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.88),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 7.5),
                        child: InkWell(
                          onTap: widget.onTap,
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7.5),
                            child: Text(
                              widget.buttonText,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: widget.buttonTextColor ??
                                    context.theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
