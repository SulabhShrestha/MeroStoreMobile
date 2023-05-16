import 'dart:ui';

import 'package:merostore_mobile/models/store.dart';
import 'package:merostore_mobile/services/store_web_services.dart';

class StoreViewModel {
  final _storeWebServices = StoreWebServices();

  Future<void> addNewStore({
    required Map<String, dynamic> newStore,
    required VoidCallback onStockAdded,
    required VoidCallback onFailure,
  }) async {
    bool isAdded = await _storeWebServices.addNewStore(
      newStore: newStore,
    );

    if (isAdded) {
      onStockAdded();
    } else {
      onFailure();
    }
  }

  Future<List<Store>> getAllStores() async {
    return _storeWebServices.getAllStores();
  }
}
