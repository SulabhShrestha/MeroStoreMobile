import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/utils/constants/spaces.dart';

/// This widget provides to indicate what it is,
/// [errorToDisplay] is responsible to show if the field is empty or not.

class TextFieldWithHeading extends StatelessWidget {
  final String heading;
  final bool isImportant;
  final FocusNode? focusNode;
  final int maxLines;
  final String? errorToDisplay;
  final TextInputType? keyboardType;
  final String? hintText;
  final List<String>? autofillHints;
  // for getting value
  final TextEditingController? controller;

  const TextFieldWithHeading({
    Key? key,
    this.focusNode,
    required this.maxLines,
    required this.heading,
    required this.isImportant,
    this.autofillHints,
    this.controller,
    this.errorToDisplay,
    this.keyboardType,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '$heading:',
            style: const TextStyle(
              color: ConstantAppColors.secondaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            children: <TextSpan>[
              TextSpan(
                text: isImportant ? '*' : '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ConstantAppColors.redColor,
                ),
              ),
            ],
          ),
        ),
        ConstantSpaces.height4,
        TextField(
          cursorColor: ConstantAppColors.primaryColor,
          focusNode: focusNode,
          maxLines: maxLines,
          minLines: 1,
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorToDisplay,
            fillColor: errorToDisplay != null
                ? ConstantAppColors.redColor.withOpacity(0.3)
                : ThemeData().inputDecorationTheme.fillColor,
          ),
          style: const TextStyle(
            fontSize: 18,
          ),
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
