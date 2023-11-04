import 'package:flutter/material.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/views/core_widgets/custom_text_button.dart';

/// Duration filter for [SummaryPage]
///
class DurationFilterButtons extends StatefulWidget {
  final ValueChanged<String> onButtonTap;

  const DurationFilterButtons({
    Key? key,
    required this.onButtonTap,
  }) : super(key: key);

  @override
  State<DurationFilterButtons> createState() => _DurationFilterButtonsState();
}

class _DurationFilterButtonsState extends State<DurationFilterButtons> {
  // Filter buttons
  List<String> buttonNames = [
    "Year",
    "Month",
    "Week",
  ];
  int selectedIndex = 0;

  void _onButtonTap(int index) {
    widget.onButtonTap(buttonNames[index]);
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int index = 0; index < buttonNames.length; index++)
            CustomTextButton(
              hideBackgroundUI: true,
              buttonColor: selectedIndex == index
                  ? ConstantAppColors.greenColor
                  : Theme.of(context).scaffoldBackgroundColor,
              textColor: selectedIndex == index
                  ? Colors.white
                  : ConstantAppColors.primaryColor,
              onTap: () {
                _onButtonTap(index);
              },
              text: buttonNames[index],
            ),
        ],
      ),
    );
  }
}
