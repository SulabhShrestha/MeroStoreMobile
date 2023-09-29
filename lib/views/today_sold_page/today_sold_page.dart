import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/models/sales_model.dart';
import 'package:merostore_mobile/providers/store_provider.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/view_models/sales_view_model.dart';
import 'package:merostore_mobile/views/core_widgets/custom_card.dart';
import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';

import 'pages/add_new_sales_transaction/add_new_sales_transaction.dart';

class TodaySoldPage extends ConsumerStatefulWidget {
  const TodaySoldPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TodaySoldPage> createState() => _TodaySoldPageState();
}

class _TodaySoldPageState extends ConsumerState<TodaySoldPage> {
  late Future<List<Sales>> salesFuture;
  bool newStockAdded = false;

  Offset? _tapPosition;

  @override
  void initState() {
    super.initState();
    salesFuture = fetchSalesRecords(); // when [InStockPage] is initially loaded
  }

  // when any update is taken place
  Future<List<Sales>> fetchSalesRecords() async {
    final stocks = await SalesViewModel().getAllSales();
    return stocks;
  }

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    StoreNotifier storesProv = ref.read(storesProvider.notifier);

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
                onTap: (val) {},
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
              child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(
                      label: Text('Column A'),
                      size: ColumnSize.L,
                    ),
                    DataColumn(
                      label: Text('Column B'),
                    ),
                    DataColumn(
                      label: Text('Column C'),
                    ),
                    DataColumn(
                      label: Text('Column D'),
                    ),
                    DataColumn(
                      label: Text('Column NUMBERS'),
                      numeric: true,
                    ),
                  ],
                  rows: List<DataRow2>.generate(
                      100,
                      (index) => DataRow2(
                              onTap: () => changeSelectedIndex(index),
                              onLongPress: () {
                                // Show the popup menu
                                _showPopupMenu(context);
                              },
                              color: index == selectedIndex
                                  ? MaterialStateProperty.all(ConstantAppColors
                                      .blueColor
                                      .withOpacity(0.5))
                                  : null,
                              cells: [
                                DataCell(Text('A' * (10 - index % 10))),
                                DataCell(Text('B' * (10 - (index + 5) % 10))),
                                DataCell(Text('C' * (15 - (index + 5) % 10))),
                                DataCell(Text('D' * (15 - (index + 10) % 10))),
                                DataCell(
                                    Text(((index + 0.1) * 25.4).toString()))
                              ]))),
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
  void _showPopupMenu(BuildContext context) {
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
          const PopupMenuItem(
            child: Text('Edit'),
            value: 'edit',
          ),
          const PopupMenuItem(
            child: Text('Delete'),
            value: 'delete',
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
