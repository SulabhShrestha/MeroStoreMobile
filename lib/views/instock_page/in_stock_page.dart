import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/extensions/string_extensions.dart';
import 'package:merostore_mobile/models/stock_model.dart';
import 'package:merostore_mobile/providers/currently_selected_store_provider.dart';
import 'package:merostore_mobile/providers/filter_stocks_provider.dart';
import 'package:merostore_mobile/providers/stock_provider.dart';
import 'package:merostore_mobile/providers/store_provider.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/view_models/stock_view_model.dart';

import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';
import 'package:merostore_mobile/views/core_widgets/snackbar_message.dart';
import 'package:merostore_mobile/views/instock_page/pages/edit_stock/edit_stock.dart';
import 'package:merostore_mobile/views/core_widgets/record_view_dialog.dart';

import 'pages/add_new_stock/add_new_stock.dart';
import 'utils/stock_helper.dart';

class InStockPage extends ConsumerStatefulWidget {
  const InStockPage({Key? key}) : super(key: key);

  @override
  ConsumerState<InStockPage> createState() => _InStockPageState();
}

class _InStockPageState extends ConsumerState<InStockPage> {
  Offset? tapPosition; // for tracking the tap position
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final storesProv = ref.watch(storesProvider.notifier);

    final selectedStoreProv =
        ref.watch(currentlySelectedStoreProvider.notifier);

    // returns the filtered stocks based on currently selected store
    final filteredStocksNotifier = ref.watch(filteredStocksProvider.notifier);
    final filteredStocks = ref.watch(filteredStocksProvider);

    // for sorting
    int columnIndex = -1;
    bool ascending = false;

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (_, isScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              flexibleSpace: CustomDropDownBtn(
                tooltip: "Store selection",
                options: storesProv.allStoresNames,
                initialValue: selectedStoreProv.state["stock"],
                onTap: (val) {
                  selectedStoreProv.setSelectedStore("stock", val);
                  filteredStocksNotifier.filterStocks();
                },
              ),
            ),
          ];
        },
        body: Stack(
          children: [
            Listener(
              onPointerDown: (event) {
                tapPosition = event.position;
              },
              child: filteredStocks.isEmpty
                  ? const Text("Nothing to display.")
                  : DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 500,
                      sortAscending: true,
                      sortColumnIndex: 0,
                      sortArrowBuilder: (bool ascending, bool sorted) {
                        log("Sorted arrow builder: $ascending $sorted");
                        if (sorted) {
                          return Icon(
                            ascending
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: Colors.blue,
                          );
                        }
                        return null; // Return null for columns that are not currently sorted.
                      },
                      columns: filteredStocksNotifier
                          .getUniqueProperties()
                          .map((prop) {
                        log("Data column: ${prop["numeric"]} ${prop["heading"]}");
                        return DataColumn2(
                          numeric: prop["numeric"] ? true : false,
                          onSort: (index, ascending) {
                            log("Inside Column: $index $ascending");
                          },
                          label: Align(
                              alignment: Alignment.center,
                              child: Text(prop["heading"])),
                        );
                      }).toList(),
                      rows: List<DataRow2>.generate(
                          filteredStocks.length,
                          (index) => DataRow2(
                                onTap: () => changeSelectedIndex(index),
                                onDoubleTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => RecordViewDialog(
                                            displaying: "Stock",
                                            stockModel: filteredStocks[index],
                                          ));
                                },
                                onLongPress: () {
                                  // Show the popup menu
                                  _showPopupMenu(
                                      context, filteredStocks[index]);
                                },
                                color: index == selectedIndex
                                    ? MaterialStateProperty.all(
                                        ConstantAppColors.blueColor
                                            .withOpacity(0.5))
                                    : null,
                                cells: filteredStocksNotifier
                                    .getUniqueProperties()
                                    .map((prop) {
                                  final value = filteredStocks[index]
                                      .details[prop["fieldName"]];
                                  return DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        value != null
                                            ? '$value'
                                            : '-', // Convert to string or use an empty string if null
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ))),
            ),

            // add new transaction
            Positioned(
              right: 16,
              bottom: 16,
              child: AnimatedContainer(
                width: 58,
                height: 58,
                duration: const Duration(milliseconds: 250),
                child: FloatingActionButton(
                  onPressed: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const AddNewStock(),
                    ));
                  },
                  tooltip: "Add new stock",
                  child: const Icon(
                    Icons.add,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Changes the selectedIndex to highlight the selected row
  void changeSelectedIndex(int index) {
    if (index != selectedIndex) {
      setState(() => selectedIndex = index);
    }
  }

  // displays pop up menu
  void _showPopupMenu(BuildContext context, StockModel model) {
    if (tapPosition != null) {
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
          tapPosition!.dx,
          tapPosition!.dy,
          MediaQuery.of(context).size.width - tapPosition!.dx,
          MediaQuery.of(context).size.height - tapPosition!.dy,
        ),
        items: [
          PopupMenuItem(
            value: 'edit',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => EditStock(
                        stockModel: model,
                      )));
            },
            child: const Text('Edit'),
          ),
          PopupMenuItem(
            value: 'delete',
            onTap: () {
              StockViewModel()
                  .deleteStock(storeId: model.storeModel.id, stockId: model.id)
                  .then((value) {
                // deleting from local
                ref.read(stocksProvider.notifier).deleteStore(model.id);
                ref.read(filteredStocksProvider.notifier).filterStocks();
                SnackBarMessage().showMessage(context, "Deleted successfully");
              }).onError((error, stackTrace) {
                SnackBarMessage().showMessage(context, error.toString());
              });
            },
            child: const Text('Delete'),
          ),
        ],
      );
    }
  }
}
