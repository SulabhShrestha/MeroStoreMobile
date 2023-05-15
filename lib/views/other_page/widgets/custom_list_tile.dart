import 'package:flutter/material.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/utils/constants/text_styles.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Widget trailingIcon;
  final IconData? googleIconData;
  final VoidCallback? onTap;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.trailingIcon,
    this.googleIconData,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: ConstantTextStyles.normalStyle18,
      ),
      leading: Icon(
        googleIconData,
        color: ConstantAppColors.primaryColor,
        size: 28,
      ),
      trailing: trailingIcon,
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }
}
