import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/models/stock_model.dart';
import 'package:merostore_mobile/providers/stock_provider.dart';
import 'package:merostore_mobile/view_models/stock_view_model.dart';
import 'package:merostore_mobile/views/core_widgets/bold_first_word_from_text.dart';
import 'package:merostore_mobile/views/core_widgets/custom_card.dart';
import 'package:merostore_mobile/views/core_widgets/snackbar_message.dart';
import 'package:merostore_mobile/views/instock_page/pages/edit_stock/edit_stock.dart';

/// Displays record in a dialog form
class RecordViewDialog extends ConsumerWidget {
  final StockModel? stockModel;

  const RecordViewDialog({
    super.key,
    required this.stockModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => EditStock(
                            stockModel: stockModel!,
                          )));
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  StockViewModel()
                      .deleteStock(
                          storeId: stockModel!.storeModel.id,
                          stockId: stockModel!.id)
                      .then((value) {
                    // deleting from local
                    ref
                        .read(stocksProvider.notifier)
                        .deleteStore(stockModel!.id);
                    Navigator.pop(context);
                    SnackBarMessage()
                        .showMessage(context, "Deleted successfully");
                  }).onError((error, stackTrace) {
                    SnackBarMessage().showMessage(context, error.toString());
                  });
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
