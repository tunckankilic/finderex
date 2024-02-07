import 'package:finderex/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class ThemeChip extends StatefulWidget {
  final String label;
  final void Function(bool) onSelected;
  final bool isSelected;
  final bool isExpanded;
  final double? width, height;
  final bool disableAnimation;
  final bool onlyHightlight;
  final TextStyle? textStyle;
  const ThemeChip({
    Key? key,
    required this.label,
    required this.onSelected,
    this.isSelected = false,
    this.isExpanded = false,
    this.width,
    this.height,
    this.disableAnimation = false,
    this.onlyHightlight = false,
    this.textStyle,
  }) : super(key: key);

  @override
  State<ThemeChip> createState() => _ThemeChipState();
}

class _ThemeChipState extends State<ThemeChip> {
  late bool _isSelected;

  @override
  void initState() {
    _isSelected = widget.isSelected;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ThemeChip oldWidget) {
    if (oldWidget.isSelected != widget.isSelected) {
      _isSelected = widget.isSelected;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          widget.isExpanded ? EdgeInsets.zero : context.paddingLowRight / 1.5,
      width: widget.width,
      height: widget.height,
      child: FilterChip(
        padding: context.paddingLow,
        label: Row(
          mainAxisSize: widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.label,
              style: widget.textStyle ?? context.textTheme.bodyLarge,
            ),
            if (!widget.onlyHightlight)
              AnimatedSwitcher(
                duration: widget.disableAnimation
                    ? Duration.zero
                    : const Duration(milliseconds: 150),
                reverseDuration: widget.disableAnimation
                    ? Duration.zero
                    : const Duration(milliseconds: 150),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Row(
                  mainAxisSize:
                      widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
                  key: ValueKey(_isSelected),
                  children: [
                    if (_isSelected) SizedBox(width: context.lowValue),
                    if (_isSelected)
                      const Icon(
                        Icons.done,
                        size: 20,
                      ),
                  ],
                ),
              ),
          ],
        ),
        backgroundColor: Colors.blueGrey[500]!,
        onSelected: widget.onSelected,
        selected: _isSelected,
        selectedColor: Colors.lightBlueAccent[700],
        showCheckmark: true,
        side: BorderSide(
          color: _isSelected ? Colors.blueAccent : Colors.blueGrey[600]!,
        ),
      ),
    );
  }
}
