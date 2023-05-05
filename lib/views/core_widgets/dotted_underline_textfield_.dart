import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

/// Return textfield having dotted underline
///

class DottedUnderlineTextField extends StatelessWidget {
  const DottedUnderlineTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          maxLines: 1,
          keyboardType: TextInputType.number,
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
