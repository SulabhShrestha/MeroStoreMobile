import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merostore_mobile/models/stores_model.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/utils/constants/spaces.dart';
import 'package:merostore_mobile/utils/constants/text_styles.dart';
import 'package:merostore_mobile/views/core_widgets/custom_box.dart';
import 'package:merostore_mobile/views/core_widgets/custom_drop_down_btn.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
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
            ),
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

                  // items
                  for (int a = 0; a < 10; a++)
                    Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          side: BorderSide(
                              color: ConstantAppColors.primaryColor
                                  .withOpacity(0.2))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // Logo
                            Container(
                              width: 46,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ConstantAppColors.blueColor,
                                border: Border.all(),
                              ),
                              child: const FittedBox(
                                fit: BoxFit.cover,
                                child: Text("G"),
                              ),
                            ),
                            ConstantSpaces.width12,
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "G1",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "ads",
                                  style: ConstantTextStyles.dimStyle14,
                                ),
                              ],
                            ),

                            Expanded(
                              child: Text(
                                "Rs 12121",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: ConstantAppColors.primaryColor
                                      .withOpacity(0.7),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            )
                            // Name,
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
