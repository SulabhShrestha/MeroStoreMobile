import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:merostore_mobile/models/sales_model.dart';
import 'package:intl/intl.dart';

/// Holds and stores the list of all sales occurred by the user
final allSalesProvider =
    StateNotifierProvider<AllSalesProvider, Map<String, dynamic>>((ref) {
  return AllSalesProvider({});
});

class AllSalesProvider extends StateNotifier<Map<String, dynamic>> {
  AllSalesProvider(Map<String, dynamic> initialData) : super(initialData);

  // Add a method to update the map of StoreModel
  void addSales(SalesModel sales) {
    Map<String, dynamic> newState =
        Map.of(state); // Create a copy of the current state
    List<SalesModel> currentSales = newState['allSales'] ?? <SalesModel>[];
    currentSales.add(sales); // Add the new sales to the list
    newState['allSales'] = currentSales; // Update the 'allSales' key in the map
    state = newState; // Set the new state
  }

  /// Returns group sales and sum of each group
  void groupSales(
      {required String currentlySelectedStore, String groupBy = "Year"}) {
    Map<String, int> salesByDuration =
        {}; // stores sales in time framed defined in groupBy

    var currentWeek = Jiffy.now().weekOfYear;
    final soldItemsByMaterialName = <String, int>{};

    log("Inside group sales; $currentlySelectedStore, $groupBy");

    for (var salesModel in state["allSales"]) {
      log("${salesModel.storeModel.storeName} == $currentlySelectedStore");
      if (salesModel.storeModel.storeName != currentlySelectedStore) {
        continue;
      }
      // for bar graph
      var jiffyDate = Jiffy.parseFromDateTime(DateTime.parse(
          salesModel.createdAt)); // converting string time to date
      String timeFrame = groupBy == 'Year'
          ? jiffyDate.year.toString()
          : groupBy == "Month"
              ? jiffyDate.MMM
              : jiffyDate.EEEE; // how to group sales

      if (groupBy == "week" && currentWeek != jiffyDate.weekOfYear) {
        continue; // means that week is selected but the sales isn't from this week
      }
      salesByDuration.update(
        timeFrame,
        (value) => (salesModel.details["totalPrice"] as int) + value,
        ifAbsent: () => salesModel.details["totalPrice"],
      );

      // for most sold items
      soldItemsByMaterialName.update(
        salesModel.details["materialName"],
        (value) => (salesModel.details["totalPrice"] as int) + value,
        ifAbsent: () => salesModel.details["totalPrice"],
      );
    }

    Map<String, dynamic> groupSalesData = {
      'salesByDuration': Map<String, int>.from(salesByDuration),
      'soldItemsByMaterialName': Map<String, int>.from(soldItemsByMaterialName),
    };
    state.addAll(groupSalesData);
    log("AllSales Provider: $state");
  }

  // Add a method to remove a store from the list
  void removeStore(SalesModel store) {
    state = state["allSales"].where((item) => item != store).toList();
  }
}
