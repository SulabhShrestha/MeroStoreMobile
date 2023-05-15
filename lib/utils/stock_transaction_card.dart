import 'package:flutter/material.dart';
import 'package:merostore_mobile/extensions/string_ext.dart';
import 'package:merostore_mobile/utils/bold_first_word_from_text.dart';

/// This card is responsible for displaying for stock and sales transaction
class StockTransactionCard extends StatelessWidget {
  final String transactionType;
  final Map<String, dynamic> stockDetails;

  const StockTransactionCard({
    Key? key,
    required this.transactionType,
    required this.stockDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: const RoundedRectangleBorder(
        side: BorderSide(),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Written
            Row(
              children: [
                // Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(transactionType),
                      ...stockDetails.entries.map((entry) {
                        return BoldFirstWordFromText(
                          boldWord: entry.key,
                          normalWord:
                              entry.value.toString().capitalizeFirstLetter(),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
