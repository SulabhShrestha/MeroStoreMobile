import 'package:flutter/material.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';

/// This widget is responsible for return -> Heading:* as a required field

class RequiredMarking extends StatelessWidget {
  final String heading;

  const RequiredMarking({
    Key? key,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "$heading:",
        style: const TextStyle(
          color: ConstantAppColors.secondaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        children: const <TextSpan>[
          TextSpan(
            text: '*',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ConstantAppColors.redColor,
            ),
          ),
        ],
      ),
    );
  }
}
