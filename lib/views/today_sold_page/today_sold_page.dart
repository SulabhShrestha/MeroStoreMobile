import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/models/sales_model.dart';
import 'package:merostore_mobile/providers/currently_selected_store_provider.dart';
import 'package:merostore_mobile/providers/filter_sales_provider.dart';
import 'package:merostore_mobile/providers/today_sales_provider.dart';
import 'package:merostore_mobile/providers/store_provider.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/view_models/sales_view_model.dart';
import 'package:merostore_mobile/views/core_widgets/custom_card.dart';
import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';
import 'package:merostore_mobile/views/core_widgets/record_view_dialog.dart';
import 'package:merostore_mobile/views/core_widgets/snackbar_message.dart';
import 'package:merostore_mobile/views/today_sold_page/pages/edit_sales_transaction/edit_sales_transaction.dart';

import 'pages/add_new_sales_transaction/add_new_sales_transaction.dart';

class TodaySoldPage extends ConsumerStatefulWidget {
  const TodaySoldPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TodaySoldPage> createState() => _TodaySoldPageState();
}

class _TodaySoldPageState extends ConsumerState<TodaySoldPage> {
  late Future<List<SalesModel>> salesFuture;
  bool newStockAdded = false;

  Offset? _tapPosition;

  @override
  void initState() {
    super.initState();
    salesFuture = fetchSalesRecords(); // when [InStockPage] is initially loaded
  }

  // when any update is taken place
  Future<List<SalesModel>> fetchSalesRecords() async {
    final stocks = await SalesViewModel().getTodaySales();
    return stocks;
  }

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    StoreNotifier storesProv = ref.read(storesProvider.notifier);

    final selectedStoreProv =
        ref.watch(currentlySelectedStoreProvider.notifier);

    // returns the filtered stocks based on currently selected store
    final filteredSalesNotifier = ref.watch(filteredSalesProvider.notifier);
    final filteredSales = ref.watch(filteredSalesProvider);

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
                onTap: (val) {
                  selectedStoreProv.setSelectedStore("stock", val);
                  filteredSalesNotifier.filterSales();
                },
              ),
            ),
          ];
        },
        body: Stack(
          children: [
            Listener(
              onPointerDown: (event) {
                _tapPosition = event.position;
              },
              child: filteredSales.isEmpty
                  ? const Text("Nothing to display.")
                  : DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 600,
                      columns: filteredSalesNotifier
                          .getUniqueProperties()
                          .map((prop) {
                        return DataColumn2(
                          label: Align(
                              alignment: Alignment.center,
                              child: Text(prop["heading"])),
                        );
                      }).toList(),
                      rows: List<DataRow2>.generate(
                        filteredSales.length,
                        (index) => DataRow2(
                          onTap: () => changeSelectedIndex(index),
                          onDoubleTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => RecordViewDialog(
                                      salesModel: filteredSales[index],
                                      displaying: "Sales",
                                    ));
                          },
                          onLongPress: () {
                            // Show the popup menu
                            _showPopupMenu(context, filteredSales[index]);
                          },
                          color: index == selectedIndex
                              ? MaterialStateProperty.all(
                                  ConstantAppColors.blueColor.withOpacity(0.5))
                              : null,
                          cells: filteredSalesNotifier
                              .getUniqueProperties()
                              .map((prop) {
                            final value =
                                filteredSales[index].details[prop["fieldName"]];
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
                        ),
                      )),
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
                    bool? result = await Navigator.of(context)
                        .push<bool?>(MaterialPageRoute(
                      builder: (_) => const AddNewSalesTransaction(),
                    ));

                    if (result == true) {
                      setState(() {
                        newStockAdded = true;
                      });
                    }
                  },
                  tooltip: "Add new sales transaction",
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
  void _showPopupMenu(BuildContext context, SalesModel model) {
    if (_tapPosition != null) {
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
          _tapPosition!.dx,
          _tapPosition!.dy,
          MediaQuery.of(context).size.width - _tapPosition!.dx,
          MediaQuery.of(context).size.height - _tapPosition!.dy,
        ),
        items: [
          PopupMenuItem(
            value: 'edit',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => EditSalesTransaction(
                        salesModel: model,
                      )));
            },
            child: const Text('Edit'),
          ),
          PopupMenuItem(
            value: 'delete',
            onTap: () {
              SalesViewModel()
                  .deleteSales(storeId: model.storeModel.id, salesId: model.id)
                  .then((value) {
                // deleting from local
                ref.read(todaySalesProvider.notifier).deleteSales(model.id);
                ref.read(filteredSalesProvider.notifier).filterSales();
                SnackBarMessage().showMessage(context, "Deleted successfully");
              }).onError((error, stackTrace) {
                SnackBarMessage().showMessage(context, error.toString());
              });
            },
            child: const Text('Delete'),
          ),
        ],
      ).then((value) {
        if (value == 'edit') {
          // Handle edit action
        } else if (value == 'delete') {
          // Handle delete action
        }
      });
    }
  }
}
