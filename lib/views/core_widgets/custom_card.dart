import 'package:flutter/material.dart';
import 'package:merostore_mobile/extensions/string_ext.dart';
import 'package:merostore_mobile/views/core_widgets/bold_first_word_from_text.dart';

/// This card is responsible for displaying for stock, store and sales transaction
class CustomCard extends StatelessWidget {
  // What to display
  final String displaying;

  // For Stock
  final String? transactionType;
  final Map<String, dynamic>? stockDetails;

  // For Store displaying
  final String? storeName;
  final List<dynamic>? quantityTypes;
  final List<dynamic>? transactionTypes;

  const CustomCard({
    Key? key,
    this.transactionType,
    this.stockDetails,
    this.storeName,
    this.quantityTypes,
    this.transactionTypes,
    required this.displaying,
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
                      if (displaying == "Stock") ..._displayingStock(),
                      if (displaying == "Store") ..._displayingStore(),
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

  _displayingStore() {
    return [
      BoldFirstWordFromText(boldWord: "Store Name", normalWord: storeName!),
      BoldFirstWordFromText(
          boldWord: "Quantity Types", normalWord: quantityTypes!.toString()),
      BoldFirstWordFromText(
          boldWord: "Transaction Type",
          normalWord: transactionTypes!.toString()),
    ];
  }

  _displayingStock() {
    return [
      Text(transactionType!),
      Text(storeName!),
      ...stockDetails!.entries.map((entry) {
        return BoldFirstWordFromText(
          boldWord: entry.key,
          normalWord: entry.value.toString().capitalizeFirstLetter(),
        );
      }).toList(),
    ];
  }
}
