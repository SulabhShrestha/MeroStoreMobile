import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/models/stock_model.dart';
import 'package:merostore_mobile/providers/stock_provider.dart';
import 'package:merostore_mobile/providers/store_provider.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/views/core_widgets/custom_card.dart';

import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';

import 'package:merostore_mobile/views/instock_page/utils/stock_helper.dart';

import 'pages/add_new_stock/add_new_stock.dart';

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
    final stocksProv = ref.watch(stocksProvider.notifier);

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
              actions: [
                Material(
                  type: MaterialType
                      .transparency, //Makes it usable on any background color
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ConstantAppColors.primaryColor,
                        width: 1.0,
                      ),
                      color: ConstantAppColors.greenColor,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      //This keeps the splash effect within the circle
                      borderRadius: BorderRadius.circular(
                          100.0), //Something large to ensure a circle
                      onTap: () {},
                      splashColor: Colors.white38,
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.search,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ];
        },
        body: Stack(
          children: [
            Listener(
              onPointerDown: (event){
                tapPosition = event.position;
              },
              child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: stocksProv.getUniqueProperties().map((prop){

                      return DataColumn2(
                        label: Text(prop["heading"]),

                      );

                    return const DataColumn2(label: Text(""));
                  }).toList(),

                  rows: List<DataRow2>.generate(
                      100,
                          (index) => DataRow2(

                          onTap: () => changeSelectedIndex(index),
                          onLongPress: () {
                            // Show the popup menu
                            _showPopupMenu(context);
                          },

                          color: index == selectedIndex
                              ? MaterialStateProperty.all(
                              ConstantAppColors.blueColor.withOpacity(0.5))
                              : null,
                          cells: [
                            DataCell(Text('A' * (10 - index % 10))),
                            DataCell(Text('B' * (10 - (index + 5) % 10))),
                            DataCell(Text('C' * (15 - (index + 5) % 10))),
                            DataCell(Text('C' * (15 - (index + 5) % 10))),
                          ],))),
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
  void _showPopupMenu(BuildContext context) {
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
            child: Text('Edit'),
            value: 'edit',
          ),
          PopupMenuItem(
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
