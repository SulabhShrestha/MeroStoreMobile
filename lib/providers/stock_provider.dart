import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/models/stock_model.dart';

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

  void updateStockById(
      {required String id, required Map<String, dynamic> data}) {
    final updatedState = state.map((store) {
      if (store.id == id) {
        // If this is the store to update, create a new store with the updated data
        return store.copyWith(
          id: data['id'],
          storeName: data['storeName'],
          // quantityTypes: data['quantityTypes'],
          // transactionTypes: data['transactionTypes'],
        );
      } else {
        // If this is not the store to update, return the original store
        return store;
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
  }

  /// checks if currently adding store is already added
  bool contains(String storeName) {
    return state.any((store) => store.storeName == storeName);
  }
}
