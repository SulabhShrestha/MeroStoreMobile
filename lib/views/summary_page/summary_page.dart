import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:merostore_mobile/providers/store_provider.dart';
import 'package:merostore_mobile/utils/arrangement_order.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/utils/constants/spaces.dart';
import 'package:merostore_mobile/utils/constants/text_styles.dart';
import 'package:merostore_mobile/view_models/sales_view_model.dart';
import 'package:merostore_mobile/views/core_widgets/custom_box.dart';
import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';
import 'package:merostore_mobile/views/summary_page/widgets/duration_filter_buttons.dart';
import 'package:merostore_mobile/views/summary_page/widgets/item_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class SummaryPage extends ConsumerStatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends ConsumerState<SummaryPage> {
  final List<_SalesData> data = [
    _SalesData('Jan', 3000),
    _SalesData('Feb', 280),
    _SalesData('Mar', 3400),
    _SalesData('Apr', 3220),
    _SalesData('May', 4290),
    _SalesData('June', 2090),
    _SalesData('July', 1090),
    _SalesData('Aug', 4090),
    _SalesData('Sep', 1090),
    _SalesData('Oct', 2090),
    _SalesData('Nov', 3090),
    _SalesData('Dec', 900),
  ];

  // To store all list of stores
  List<String> allStoreList = [];

  @override
  Widget build(BuildContext context) {
    final storesProv = ref.watch(storesProvider.notifier);
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
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: ConstantAppColors.primaryColor,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: ConstantAppColors.greenColor,
                      child: IconButton(
                        color: Colors.green,
                        splashRadius: 32,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          color: ConstantAppColors.primaryColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(48),
                  child: DurationFilterButtons(),
                )),
          ];
        },
        body: ListView(
          children: [
            CustomBox(
              padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
              child: Column(
                children: [
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      interval: 1,
                      arrangeByIndex: true,
                      autoScrollingDelta: 6, // shows only 6 at a time
                      autoScrollingMode:
                          AutoScrollingMode.start, // show from beginning
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    primaryYAxis: NumericAxis(
                      numberFormat: NumberFormat("Rs#"),
                    ),
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePanning: true, //horizontal scroll
                      enablePinching: true,
                      zoomMode: ZoomMode.x,
                      maximumZoomLevel: 0.5,
                    ),
                    series: <ChartSeries<_SalesData, String>>[
                      LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Sales',
                      )
                    ],
                  ),
                ],
              ),
            ),

            ConstantSpaces.height8,

            // Content
            CustomBox(
              child: Column(
                children: [
                  ConstantSpaces.height4,
                  const Text(
                    "Most sold items",
                    style: ConstantTextStyles.redHeading20,
                  ),
                  ConstantSpaces.height16,

                  // Most sold items
                  FutureBuilder(
                    future: SalesViewModel().getAllSales(
                        arrangementOrder: ArrangementOrder.descending),
                    builder: (context, snapshot) {
                      // showing indicator
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      // if we have data, can be empty or not
                      else if (snapshot.hasData) {
                        log("Summary page; ${snapshot.data}, ${snapshot.data!.length}");

                        // if it is empty
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("No data found"),
                          );
                        }

                        return Column(
                          children: [
                            // we are having some data
                            for (var data in snapshot.data!)
                              ItemCard(
                                title: data.details["Material Name"].toString(),
                                amount: data.details["Total Price"].toString(),
                              ),
                          ],
                        );
                      }

                      // Something unexpected happened
                      return const Center(
                        child: Text("Something went wrong."),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
