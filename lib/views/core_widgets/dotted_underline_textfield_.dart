import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

/// Return textfield having dotted underline
///

class DottedUnderlineTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const DottedUnderlineTextField({
    Key? key,
    this.controller,

    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          maxLines: 1,
          keyboardType: keyboardType,
          cursorColor: ConstantAppColors.primaryColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DottedLine(
            dashColor: ConstantAppColors.primaryColor.withOpacity(0.5),
            lineThickness: 2,
          ),
        ),
      ],
    );
  }
}
