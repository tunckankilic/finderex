import 'dart:io';

import 'package:finderex/common/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class ClassicLoadingOverlay extends StatelessWidget {
  final ValueNotifier<OverlayEntry?> overlayEntry;
  const ClassicLoadingOverlay({
    super.key,
    required this.overlayEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      right: 0,
      child: Material(
        color: Colors.black26,
        child: SafeArea(
          child: Center(
            child: Center(
              child: Container(
                padding: context.paddingNormal,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.theme.colorScheme.background.withOpacity(0.35),
                  /*border: AppTheme().boxBorderForShadow,
                  boxShadow: [
                    AppTheme().boxShadowSmall,
                  ],*/
                ),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: (Platform.isIOS == true)
                          ? Colors.white
                          : Colors.transparent,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 3.25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
