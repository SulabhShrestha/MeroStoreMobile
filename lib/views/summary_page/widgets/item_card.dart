import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/utils/constants/spaces.dart';
import 'package:merostore_mobile/views/summary_page/summary_page.dart';

/// Displays items in [SummaryPage] in most sold sections
class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.title, required this.amount});

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          side: BorderSide(
              color: ConstantAppColors.primaryColor.withOpacity(0.2))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Logo
            Container(
              width: 46,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ConstantAppColors.blueColor,
                border: Border.all(),
              ),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(title[0].toUpperCase()),
              ),
            ),
            ConstantSpaces.width12,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title.capitalize(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            Expanded(
              child: Text(
                "Rs $amount",
                style: TextStyle(
                  fontSize: 18,
                  color: ConstantAppColors.primaryColor.withOpacity(0.7),
                ),
                textAlign: TextAlign.end,
              ),
            )
            // Name,
          ],
        ),
      ),
    );
  }
}
