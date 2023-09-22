import 'package:flutter/cupertino.dart';
import 'package:merostore_mobile/models/store_model.dart';

/// This stores list of [Store] and uses [Provider] to update them in real-time
class Stores extends ChangeNotifier {
  final List<Store> _stores = [];

  // adding new store
  void addStore(Store newStore) {
    _stores.add(newStore);
    notifyListeners();
  }

  List<Store> get allStores => _stores;

  Store getStoreById(String id) {
    return _stores.firstWhere((store) => store.id == id);
  }

  void updateStoreById(
      {required String id, required Map<String, dynamic> data}) {
    int index = _stores
        .indexWhere((store) => store.id == id); // getting index of passed store

    // copy of store to be updated
    final updatedStore = _stores[index].copyWith(
      id: data['id'],
      storeName: data['storeName'],
      quantityTypes: data['quantityTypes'],
      transactionTypes: data['transactionTypes'],
    );

    // updating store
    _stores[index] = updatedStore;
    notifyListeners();
  }

  // deleting old store
  void deleteStore(String id) {
    _stores.removeWhere((store) => store.id == id);
    notifyListeners();
  }

  /// checks if currently adding store is already added
  bool contains(String storeName) {
    return _stores.any((store) => store.storeName == storeName);
  }

  /// Returns all the names of the stores stored
  List<String> get allStoresNames =>
      _stores.map((store) => store.storeName).toList();

  /// Returns all the quantity types of the stores stored
  List<String> allQuantityTypes({required String storeName}) {
    List<dynamic> quantityTypes = _stores
        .where((store) => store.storeName == storeName)
        .first
        .quantityTypes;

    return quantityTypes.cast<String>().toList();
  }

  /// Returns all the quantity types of the stores stored
  List<String> allTransactionTypes({required String storeName}) {
    List<dynamic> transactionTypes = _stores
        .where((store) => store.storeName == storeName)
        .first
        .transactionTypes;

    return transactionTypes.cast<String>().toList();
  }
}
