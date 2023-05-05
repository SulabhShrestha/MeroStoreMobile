import 'package:flutter/material.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';

/// This is particularly used in [AddNewStock] and
/// [AddNewSalesTransaction] for denoting non-required value

class NormalHeadingForAddingNewItem extends StatelessWidget {
  final String text;
  const NormalHeadingForAddingNewItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text:",
      style: const TextStyle(
        color: ConstantAppColors.secondaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
