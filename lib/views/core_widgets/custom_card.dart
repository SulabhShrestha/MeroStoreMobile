import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:merostore_mobile/models/store_model.dart';
import 'package:merostore_mobile/views/core_widgets/bold_first_word_from_text.dart';
import 'package:merostore_mobile/views/core_widgets/edit_delete_button.dart';

/// This card is responsible for displaying for stock, store and sales transaction
class CustomCard extends StatelessWidget {
  // What to display, store or sales
  final String displaying;

  // for store data
  final Store? store;

  // For Stock
  final String? transactionType;
  final Map<String, dynamic>? stockDetails;

  // Display delete button or not from [EditDeleteButton]
  final bool enableDeleteOption;

  const CustomCard({
    Key? key,
    this.transactionType,
    this.stockDetails,
    this.enableDeleteOption = true,
    this.store,
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
                      if (displaying == "Store")
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: _displayingStore())),
                            EditDeleteButton(
                              id: store!.id,
                              enableDeleteOption: enableDeleteOption,
                            ),
                          ],
                        ),
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
      BoldFirstWordFromText(
          boldWord: "Store Name", normalWord: store!.storeName),
      BoldFirstWordFromText(
          boldWord: "Quantity Types",
          normalWord: store!.quantityTypes.toString()),
      BoldFirstWordFromText(
          boldWord: "Transaction Type",
          normalWord: store!.transactionTypes.toString()),
    ];
  }

  _displayingStock() {
    return [
      Text(transactionType!),
      // Text(storeName!),
      ...stockDetails!.entries.map((entry) {
        return BoldFirstWordFromText(
          boldWord: entry.key,
          normalWord: entry.value.toString().capitalize(),
        );
      }).toList(),
    ];
  }
}
