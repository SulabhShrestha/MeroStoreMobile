import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:merostore_mobile/models/stock_model.dart';
import 'package:merostore_mobile/models/stores_model.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/view_models/stock_view_model.dart';
import 'package:merostore_mobile/views/add_new_stock/add_new_stock.dart';
import 'package:merostore_mobile/views/core_widgets/custom_card.dart';
import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';
import 'package:provider/provider.dart';

class InStockPage extends StatefulWidget {
  const InStockPage({Key? key}) : super(key: key);

  @override
  State<InStockPage> createState() => _InStockPageState();
}

class _InStockPageState extends State<InStockPage> {
  late Future<List<Stock>> stocksFuture;
  bool newStockAdded = false;

  @override
  void initState() {
    super.initState();
    stocksFuture = fetchStocks(); // when [InStockPage] is initially loaded
  }

  // when any update is taken place
  Future<List<Stock>> fetchStocks() async {
    final stockViewModel = StockViewModel();
    final stocks = await stockViewModel.getAllStocks();
    return stocks;
  }

  @override
  Widget build(BuildContext context) {
    final stores = Provider.of<Stores>(context);
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
                options: stores.allStoresNames,
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
            FutureBuilder(
                future: newStockAdded ? fetchStocks() : stocksFuture,
                builder: (context, snapshot) {
                  log("Fetching");
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          for (Stock element in snapshot.data!)
                            CustomCard(
                              id: element.id,
                              storeName: element.storeName,
                              transactionType: element.transactionType,
                              stockDetails: element.details,
                              displaying: "Stock",
                            ),
                        ],
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),

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
                      builder: (_) => AddNewStock(stores: stores),
                    ));

                    if (result == true) {
                      setState(() {
                        newStockAdded = true;
                      });
                    }
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
}
