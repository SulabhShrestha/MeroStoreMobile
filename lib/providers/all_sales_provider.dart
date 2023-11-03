import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/models/sales_model.dart';

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
  Map<String, int> groupSales() {
    return state.fold({}, (Map<String, int> result, SalesModel sale) {
      if (result.containsKey(sale.details["materialName"])) {
        // If the name is already in the result map, add the sale amount to the existing total
        result[sale.details["materialName"]] =
            sale.details["totalPrice"] + result[sale.details["materialName"]];
      } else {
        // If the name is not in the result map, create a new entry with the sale amount
        result[sale.details["materialName"]] = sale.details["totalPrice"];
      }
      return result;
    });
  }

  // Add a method to remove a store from the list
  void removeStore(SalesModel store) {
    state = state.where((item) => item != store).toList();
  }
}
