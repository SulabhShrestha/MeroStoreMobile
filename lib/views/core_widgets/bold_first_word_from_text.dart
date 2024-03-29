import 'package:flutter/material.dart';

/// This widget bolds the first word and leaves rest unchanged
///

class BoldFirstWordFromText extends StatelessWidget {
  final String boldWord;
  final String normalWord;
  final double? boldWordSize;
  final Color? boldWordColor;

  const BoldFirstWordFromText({
    Key? key,
    required this.boldWord,
    required this.normalWord,
    this.boldWordSize,
    this.boldWordColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: "$boldWord ", // Color of this should be
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: boldWordColor ?? Colors.black,
              fontSize: boldWordSize ?? 16,
            ),
          ),
          TextSpan(
            text: normalWord,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
