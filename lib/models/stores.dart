import 'package:flutter/cupertino.dart';
import 'package:merostore_mobile/models/store.dart';

/// This stores list of [Store] and uses [Provider] to update them in real-time
class Stores extends ChangeNotifier {
  final List<Store> _stores = [];

  // adding new store
  void addStore(Store newStore) {
    _stores.add(newStore);

    notifyListeners();
  }

  List<Store> get allStores => _stores;

  // deleting old store
  void deleteStore(Store oldStore) {
    _stores.removeWhere((store) => store.storeName == oldStore.storeName);
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
