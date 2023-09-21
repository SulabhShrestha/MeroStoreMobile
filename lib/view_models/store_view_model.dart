import 'dart:developer';
import 'dart:ui';

import 'package:merostore_mobile/models/store_model.dart';
import 'package:merostore_mobile/services/store_web_services.dart';

class StoreViewModel {
  final _storeWebServices = StoreWebServices();

  Future<void> addNewStore({
    required Map<String, dynamic> newStore,
    required Function(Store store) onStockAdded,
    required VoidCallback onFailure,
  }) async {
    Map<String, dynamic> response = await _storeWebServices.addNewStore(
      newStore: newStore,
    );

    if (response["isSaved"]) {
      onStockAdded(response["savedStore"]);
    } else {
      onFailure();
    }
  }

  Future<List<Store>> getAllStores() async {
    List<Store> stores = await _storeWebServices.getAllStores();
    log("Stores: ${stores.first.storeName}");
    return stores;
  }

  Future<void> deleteStore({required String id}) async {
    await _storeWebServices.deleteStore(id: id);
  }
}
