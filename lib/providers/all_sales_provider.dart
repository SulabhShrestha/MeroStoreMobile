import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:merostore_mobile/models/sales_model.dart';
import 'package:intl/intl.dart';

/// Holds and stores the list of all sales occurred by the user
final allSalesProvider =
    StateNotifierProvider<AllSalesProvider, List<SalesModel>>((ref) {
  return AllSalesProvider([]);
});

class AllSalesProvider extends StateNotifier<List<SalesModel>> {
  AllSalesProvider(List<SalesModel> initialData) : super(initialData);

  // Add a method to update the list of StoreModel
  void addSales(SalesModel store) {
    state = [...state, store];
  }

  /// Returns group sales and sum of each group
  List<Map<String, int>> groupSales({String groupBy = "year"}) {
    final salesByDuration =
        <String, int>{}; // stores sales in time framed defined in groupBy

    var currentWeek = Jiffy.now().weekOfYear;

    final soldItemsByMaterialName = <String, Map<String, int>>{};

    for (var salesModel in state) {
      var jiffyDate = Jiffy.parseFromDateTime(DateTime.parse(
          salesModel.createdAt)); // converting string time to date
      String timeFrame = groupBy == 'year'
          ? jiffyDate.year.toString()
          : groupBy == "month"
              ? jiffyDate.MMM
              : jiffyDate.weekOfYear.toString(); // how to group sales

      if (groupBy == "week" && currentWeek != jiffyDate.weekOfYear) {
        continue; // means that week is selected but the sales isn't from this week
      }
      salesByDuration.update(
        jiffyDate.EEEE,
        (value) => (salesModel.details["totalPrice"] as int) + value,
        ifAbsent: () => salesModel.details["totalPrice"],
      );
      log("month: ${jiffyDate.MMM}");
    }

    log(salesByDuration.toString());

    return [
      salesByDuration,
    ];
  }

  // Add a method to remove a store from the list
  void removeStore(SalesModel store) {
    state = state.where((item) => item != store).toList();
  }
}
