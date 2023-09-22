import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/models/sales_model.dart';
import 'package:merostore_mobile/providers/store_provider.dart';
import 'package:merostore_mobile/view_models/sales_view_model.dart';
import 'package:merostore_mobile/views/add_new_sales_transaction/add_new_sales_transaction.dart';
import 'package:merostore_mobile/views/core_widgets/custom_card.dart';
import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';

class TodaySoldPage extends ConsumerStatefulWidget {
  const TodaySoldPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TodaySoldPage> createState() => _TodaySoldPageState();
}

class _TodaySoldPageState extends ConsumerState<TodaySoldPage> {
  late Future<List<Sales>> salesFuture;
  bool newStockAdded = false;

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
            // list of sales transactions
            FutureBuilder(
                future: newStockAdded ? fetchSalesRecords() : salesFuture,
                builder: (context, snapshot) {
                  log("Fetching");
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("Nothing to display."),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          for (Sales element in snapshot.data!)
                            CustomCard(
                              // id: element.id,
                              // storeName: element.storeName,
                              transactionType: element.transactionType,
                              stockDetails: element.details,
                              displaying: "Stock",
                            ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong."),
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
}
