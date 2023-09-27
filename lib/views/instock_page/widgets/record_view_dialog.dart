import 'package:flutter/material.dart';
import 'package:merostore_mobile/models/stock_model.dart';
import 'package:merostore_mobile/views/core_widgets/bold_first_word_from_text.dart';
import 'package:merostore_mobile/views/core_widgets/custom_card.dart';

/// Displays record in a dialog form
class RecordViewDialog extends StatelessWidget {
  final StockModel? stockModel;

  const RecordViewDialog({
    super.key,
    required this.stockModel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // edit delete button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),

          // record details
          CustomCard(displaying: "Stock", stock: stockModel),
        ],
      ),
    );
  }
}
