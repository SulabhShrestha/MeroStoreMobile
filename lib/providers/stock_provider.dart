import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/extensions/string_extensions.dart';
import 'package:merostore_mobile/models/stock_model.dart';
import 'package:merostore_mobile/models/store_model.dart';
import 'package:merostore_mobile/providers/currently_selected_store_provider.dart';
import 'package:merostore_mobile/views/instock_page/utils/stock_helper.dart';

final stocksProvider =
    StateNotifierProvider<StocksNotifier, List<StockModel>>((ref) {
  return StocksNotifier();
});

/// This stores list of [StockModel] and uses [Provider] to update them in real-time
class StocksNotifier extends StateNotifier<List<StockModel>> {
  StocksNotifier() : super([]); // initializing with empty list

  // adding new store
  void addStock(StockModel newStock) {
    state = [...state, newStock];
  }

  List<StockModel> get allStocks => state;

  StockModel getStockById(String id) {
    return state.firstWhere((stock) => stock.id == id);
  }

  List<StockModel> getStocksByStore(String storeName) {
    log("Getting stock");
    return state.where((stock) => stock.storeName == storeName).toList();
  }

  void updateStockById(
      {required String id, required Map<String, dynamic> data}) {
    log("Data; $data");
    final updatedState = state.map((stock) {
      if (stock.id == id) {
        // If this is the store to update, create a new store with the updated data

        return stock.copyWith(
          id: data['id'],
          storeName: data['storeName'],
          details: data['details'],
          transactionType: data['transactionType'],
          storeModel: StoreModel.fromJSON(data["storeId"]),
        );
      } else {
        // If this is not the store to update, return the original store
        return stock;
      }
    }).toList();

    // Update the state with the new list containing the updated store
    state = updatedState;
  }

  // deleting old store
  void deleteStore(String id) {
    state = [
      for (StockModel store in state)
        if (store.id != id) store
    ];

    log("State: $state");
  }

  /// checks if currently adding store is already added
  bool contains(String storeName) {
    return state.any((store) => store.storeName == storeName);
  }
}
