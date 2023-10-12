import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';

import 'custom_drop_down_btn.dart';

/// Return dotted underline textfield with dropdownbutton
/// Useful in case of brought quantity
///

class DottedUnderlineTextFieldWithDropDownBtn extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialSelectedValue;
  final TextInputType keyboardType;
  final List<String> quantityTypes;
  final ValueChanged<String> onSelected;

  const DottedUnderlineTextFieldWithDropDownBtn({
    Key? key,
    this.controller,
    this.initialSelectedValue,
    required this.keyboardType,
    required this.quantityTypes,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.55,
          child: Column(
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
          ),
        ),
        CustomDropDownBtn(
          initialValue: initialSelectedValue,
          options: quantityTypes,
          tooltip: "Types of goods quantity",
          hideBackgroundUI: true,
          onTap: onSelected,
        ),
      ],
    );
  }
}
