import 'package:riverpod/riverpod.dart';

class SelectedStoreNotifier extends StateNotifier<Map<String, dynamic>> {
  SelectedStoreNotifier()
      : super({'sales': null, 'summary': null, 'stock': null});

  /// location means which widget, can be either: sales, summary or stock
  void setSelectedStore(String location, String storeName) {
    state = {...state, location: storeName};
  }

  /// used to set all the selected store of all location at once
  void setAllSelectedStore(String storeName) {
    state = {'sales': storeName, 'summary': storeName, 'stock': storeName};
  }
}

final selectedStoreProvider =
    StateNotifierProvider<SelectedStoreNotifier, Map<String, dynamic>>((ref) {
  return SelectedStoreNotifier();
});
