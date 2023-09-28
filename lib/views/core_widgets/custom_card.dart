import 'dart:developer';
import 'dart:ffi';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:merostore_mobile/extensions/double_extension.dart';
import 'package:merostore_mobile/extensions/string_extensions.dart';
import 'package:merostore_mobile/models/stock_model.dart';
import 'package:merostore_mobile/models/store_model.dart';
import 'package:merostore_mobile/views/core_widgets/bold_first_word_from_text.dart';
import 'package:merostore_mobile/views/core_widgets/edit_delete_button.dart';

/// This card is responsible for displaying for stock, store and sales transaction
class CustomCard extends StatelessWidget {
  /// What to display, "Stock" or "Store"
  final String displaying;

  // for displaying store data,
  final StoreModel? storeModel;

  // for displaying stocks
  final StockModel? stockModel;

  // Display delete button or not from [EditDeleteButton]
  final bool enableDeleteOption;

  const CustomCard({
    Key? key,
    this.enableDeleteOption = true,
    this.storeModel,
    this.stockModel,
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
            if (displaying == "Stock")
              Row(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: _displayingStock()),
                ],
              ),
            if (displaying == "Store")
              Row(
                children: [
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: _displayingStore())),
                  EditDeleteButton(
                    id: storeModel!.id,
                    enableDeleteOption: enableDeleteOption,
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
          boldWord: "Store Name", normalWord: storeModel!.storeName),
      BoldFirstWordFromText(
          boldWord: "Quantity Types",
          normalWord: storeModel!.quantityTypes.toString()),
      BoldFirstWordFromText(
          boldWord: "Transaction Type",
          normalWord: storeModel!.transactionTypes.toString()),
    ];
  }

  _displayingStock() {
    String materialName = stockModel!.details["materialName"];
    var totalBroughtQty = stockModel!.details["broughtQuantity"] ??
        stockModel!.details["forQuantity"];
    var totalPrice =
        stockModel!.details["totalPrice"] ?? stockModel!.details["totalPrice"];
    String avgPrice =
        ((totalPrice / totalBroughtQty) as double).formatWithIntegerCheck();
    String broughtQuantityType = stockModel!.details["broughtQuantityType"];

    // since this is already captured
    // and details might have other info such as creditor or debtor name, info, description etc
    List<String> blacklistedFields = [
      "materialName",
      "broughtQuantity",
      "totalPrice",
      "broughtQuantityType",
    ];

    var widgetList = <Widget>[];
    for (var key in stockModel!.details.keys) {
      if (!blacklistedFields.contains(key)) {
        widgetList.add(
          BoldFirstWordFromText(
            boldWord: key.camelCaseToWords(),
            normalWord: stockModel!.details[key].toString(),
          ),
        );
      }
    }

    return [
      Text(stockModel!.transactionType),
      BoldFirstWordFromText(
        boldWord: "Material Name:",
        normalWord: materialName,
      ),
      BoldFirstWordFromText(
        boldWord: "Total Brought:",
        normalWord: totalBroughtQty.toString(),
      ),
      BoldFirstWordFromText(
          boldWord: "Price: ", normalWord: "$avgPrice/$broughtQuantityType"),

      // displaying other details
      ...widgetList,
    ];
  }
}
