import 'package:flutter/material.dart';

import 'app_colors.dart';

class ConstantTextStyles {
  // Heading style
  static const TextStyle redHeading20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: ConstantAppColors.redColor,
    decoration: TextDecoration.underline,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.solid,
  );
  static const TextStyle blueHeading22 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: ConstantAppColors.blueColor,
  );

  // Normal Text Style
  static const TextStyle normalStyle18 = TextStyle(
    fontSize: 18,
    color: ConstantAppColors.primaryColor,
  );
  static const TextStyle normalStyle20 = TextStyle(
    fontSize: 20,
    color: ConstantAppColors.primaryColor,
  );
  static const TextStyle normalStyle22 = TextStyle(
    fontSize: 22,
    color: ConstantAppColors.primaryColor,
  );

  // Dim type textStyle
  static const TextStyle dimStyle14 = TextStyle(
    fontSize: 14,
    color: ConstantAppColors.secondaryColor,
  );
  static const TextStyle dimStyle18 = TextStyle(
    fontSize: 18,
    color: ConstantAppColors.secondaryColor,
  );

  static const TextStyle dimStyle20 = TextStyle(
    fontSize: 20,
    color: ConstantAppColors.secondaryColor,
  );
}
