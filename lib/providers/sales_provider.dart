import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/models/sales_model.dart';
import 'package:merostore_mobile/models/stock_model.dart';
import 'package:merostore_mobile/models/store_model.dart';

final salesProvider =
    StateNotifierProvider<StocksNotifier, List<SalesModel>>((ref) {
  return StocksNotifier();
});

/// This stores list of [SalesModel] and uses [Provider] to update them in real-time
class StocksNotifier extends StateNotifier<List<SalesModel>> {
  StocksNotifier() : super([]); // initializing with empty list

  // adding new store
  void addSales(SalesModel newSales) {
    state = [...state, newSales];
  }

  List<SalesModel> get allStocks => state;

  SalesModel getStockById(String id) {
    return state.firstWhere((stock) => stock.id == id);
  }

  List<SalesModel> getSalesByStore(String storeName) {
    log("Getting stock");
    return state
        .where((sales) => sales.storeModel.storeName == storeName)
        .toList();
  }

  void updateSalesById(
      {required String id, required Map<String, dynamic> data}) {
    log("Data; $data");
    final updatedState = state.map((sales) {
      if (sales.id == id) {
        // If this is the store to update, create a new store with the updated data

        return sales.copyWith(
          id: data['id'],
          details: data['details'],
          transactionType: data['transactionType'],
          storeModel: StoreModel.fromJSON(data["storeId"]),
        );
      } else {
        // If this is not the store to update, return the original store
        return sales;
      }
    }).toList();

    // Update the state with the new list containing the updated store
    state = updatedState;
  }

  // deleting old store
  void deleteSales(String id) {
    state = [
      for (SalesModel store in state)
        if (store.id != id) store
    ];

    log("State: $state");
  }

  /// checks if currently adding store is already added
  bool contains(String storeName) {
    return state.any((store) => store.storeModel.storeName == storeName);
  }
}
