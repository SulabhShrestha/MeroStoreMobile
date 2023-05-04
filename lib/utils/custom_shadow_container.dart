import 'package:flutter/material.dart';

/// This widget is responsible for creating custom shadow type container

class CustomShadowContainer extends StatelessWidget {
  final Widget child; // What to display
  final double? height; // Height of the container
  final double width;
  final Color foregroundColor; // of front one
  final Color? backgroundColor; // of back one
  final EdgeInsets padding;
  final bool? hideBackgroundUI; // Whether to show background UI
  final VoidCallback? onTap;
  final BoxConstraints? boxConstraints;

  const CustomShadowContainer({
    super.key,
    this.width = double.infinity,
    this.padding = EdgeInsets.zero,
    this.hideBackgroundUI,
    this.onTap,
    this.boxConstraints,
    this.height,
    this.backgroundColor,
    required this.child,
    required this.foregroundColor,
  }) : assert(boxConstraints != null || height != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Visibility(
            visible: !(hideBackgroundUI ??
                false), // can directly make hideBackground UI opposite of it
            child: Transform.translate(
              offset: const Offset(4, 4),
              child: Container(
                height: height,
                width: width,
                constraints: boxConstraints,
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0),
                  color: backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: height,
            width: width,
            constraints: boxConstraints,
            padding: padding,
            decoration: BoxDecoration(
              border: Border.all(width: 2.0),
              color: foregroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}
