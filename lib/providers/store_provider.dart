import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/models/store_model.dart';

final storesProvider =
    StateNotifierProvider<StoreNotifier, List<StoreModel>>((ref) {
  return StoreNotifier();
});

/// This stores list of [StockModel] and uses [Provider] to update them in real-time
class StoreNotifier extends StateNotifier<List<StoreModel>> {
  StoreNotifier() : super([]); // initializing with empty list

  // adding new store
  void addStore(StoreModel newStore) {
    state = [...state, newStore];
  }

  List<StoreModel> get allStores => state;

  StoreModel getStoreById(String id) {
    return state.firstWhere((store) => store.id == id);
  }

  void updateStoreById(
      {required String id, required Map<String, dynamic> data}) {
    final updatedState = state.map((store) {
      if (store.id == id) {
        // If this is the store to update, create a new store with the updated data
        return store.copyWith(
          id: data['id'],
          storeName: data['storeName'],
          quantityTypes: data['quantityTypes'],
          transactionTypes: data['transactionTypes'],
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
      for (StoreModel store in state)
        if (store.id != id) store
    ];
  }

  /// checks if currently adding store is already added
  bool contains(String storeName) {
    return state.any((store) => store.storeName == storeName);
  }

  /// Returns all the names of the stores stored
  List<String> get allStoresNames =>
      state.map((store) => store.storeName).toList();

  /// Returns all the quantity types of the stores stored
  List<String> allQuantityTypes({required String storeName}) {
    List<dynamic> quantityTypes = state
        .where((store) => store.storeName == storeName)
        .first
        .quantityTypes;

    return quantityTypes.cast<String>().toList();
  }

  /// Returns all the quantity types of the stores stored
  List<String> allTransactionTypes({required String storeName}) {
    List<dynamic> transactionTypes = state
        .where((store) => store.storeName == storeName)
        .first
        .transactionTypes;

    return transactionTypes.cast<String>().toList();
  }
}
