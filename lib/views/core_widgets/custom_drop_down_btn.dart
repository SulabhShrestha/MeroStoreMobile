import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/utils/constants/text_styles.dart';

import 'custom_shadow_container.dart';

class CustomDropDownBtn extends StatefulWidget {
  final bool? hideBackgroundUI;
  final double? width;
  final List<String> options;
  final ValueChanged<String> onTap;
  final String? initialValue;

  const CustomDropDownBtn({
    Key? key,
    this.hideBackgroundUI,
    this.width,
    this.initialValue,
    required this.options,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomDropDownBtn> createState() => _CustomDropDownBtnState();
}

class _CustomDropDownBtnState extends State<CustomDropDownBtn> {
  late String _currentItemSelected;

  @override
  void initState() {
    super.initState();
    _currentItemSelected = widget.initialValue ??
        widget.options.first; // First priority is always initial value
    log("Beginning of DROPDOWNBTN: $_currentItemSelected");
  }

  @override
  Widget build(BuildContext context) {
    return CustomShadowContainer(
      height: 42,
      hideBackgroundUI: widget.hideBackgroundUI ?? false,
      width: widget.width ?? MediaQuery.of(context).size.width * 0.25,
      foregroundColor: AppColors.greenColor,
      backgroundColor: AppColors.yellowColor,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonHideUnderline(
        child: PopupMenuButton<String>(
          itemBuilder: (context) {
            return widget.options.map((str) {
              return PopupMenuItem(
                value: str,
                child: Text(
                  str,
                  style: ConstantTextStyles.normalStyle20,
                ),
              );
            }).toList();
          },
          child: Padding(
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _currentItemSelected.length < 5
                          ? _currentItemSelected
                          : ("${_currentItemSelected.substring(0, 5)}..."),
                      style: ConstantTextStyles.normalStyle22,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          onSelected: (value) {
            widget.onTap(value);
            setState(() {
              _currentItemSelected = value;
            });

            log("Inside DropDownBtn $_currentItemSelected");
          },
        ),
      ),
    );
  }
}
