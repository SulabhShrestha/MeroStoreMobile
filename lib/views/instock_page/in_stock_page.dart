import 'package:flutter/material.dart';
import 'package:merostore_mobile/models/stock.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/view_models/stock_view_model.dart';
import 'package:merostore_mobile/views/add_new_stock/add_new_stock.dart';
import 'package:merostore_mobile/views/core_widgets/custom_card.dart';
import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';

class InStockPage extends StatelessWidget {
  const InStockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StockViewModel().getAllStocks();
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
                options: const ["hello", "hi"],
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
            // add new transaction
            Positioned(
              right: 16,
              bottom: 16,
              child: AnimatedContainer(
                width: 58,
                height: 58,
                duration: const Duration(milliseconds: 250),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AddNewStock()));
                  },
                  tooltip: "Add new stock",
                  child: const Icon(
                    Icons.add,
                  ),
                ),
              ),
            ),

            FutureBuilder(
                future: StockViewModel().getAllStocks(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (Stock element in snapshot.data!)
                          CustomCard(
                            transactionType: element.transactionType,
                            stockDetails: element.details,
                            displaying: "Stock",
                          ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}
