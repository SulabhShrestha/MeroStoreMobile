import 'package:flutter/material.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/views/core_widgets/custom_shadow_container.dart';

/// Displays [TextButton]
///

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onTap,
    required this.text,
    this.hideBackgroundUI,
    this.buttonColor,
    this.textColor,
  });

  final VoidCallback onTap;
  final String text;
  final bool? hideBackgroundUI;
  final Color? buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return CustomShadowContainer(
      onTap: onTap,
      height: 42,
      width: 96,
      hideBackgroundUI: hideBackgroundUI,
      foregroundColor: buttonColor ?? ConstantAppColors.greenColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Text(
        text,
        style: TextStyle(
            color: textColor ?? ConstantAppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
