import 'package:dartx/dartx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/extensions/string_extensions.dart';
import 'package:merostore_mobile/models/stock_model.dart';
import 'currently_selected_store_provider.dart';
import 'package:merostore_mobile/views/instock_page/utils/stock_helper.dart';

import 'stock_provider.dart';

final filteredStocksProvider =
    StateNotifierProvider<FilteredStocksNotifier, List<StockModel>>((ref) {
  return FilteredStocksNotifier(ref);
});

class FilteredStocksNotifier extends StateNotifier<List<StockModel>> {
  final Ref _ref;

  FilteredStocksNotifier(this._ref) : super([]);

  /// filters the stocks based on store name
  void filterStocks({String? sortingHeading, bool? sortAscending}) {
    final selectedStore = _ref.read(currentlySelectedStoreProvider);
    final allStocks = _ref.read(stocksProvider);

    if (sortingHeading != null) {
      if (sortAscending == true) {
        allStocks.sort((a, b) => (a.details[sortingHeading] ?? "")
            .compareTo(b.details[sortingHeading] ?? ""));
      } else {
        allStocks.sort((a, b) => (b.details[sortingHeading] ?? "")
            .compareTo(a.details[sortingHeading] ?? ""));
      }
    }

    String selectedStoreName = selectedStore["stock"];

    // Filter stocks based on the selected store
    final filteredStocks = allStocks
        .where((stock) =>
            stock.storeName.toLowerCase() == selectedStoreName.toLowerCase())
        .toList();

    state = filteredStocks;
  }

  List<Map<String, dynamic>> getUniqueProperties() {
    // Extract details and collect unique property names
    Set<String> propertyNames = <String>{};

    for (var stock in state) {
      propertyNames.addAll(stock.details.keys);
    }

    List<Map<String, dynamic>> transformedProperties = [];

    // Split camelCase and join with spaces
    for (var propertyName in propertyNames) {
      List<String> words = [];

      // skip blacklisted properties to be added to the heading
      if (StockHelper().getBlacklistedHeading().contains(propertyName)) {
        continue;
      }
      transformedProperties.add({
        "heading": propertyName.camelCaseToWords(),
        "fieldName": propertyName,
        "numeric": StockHelper()
            .getHeadingContainingNumericValue()
            .contains(propertyName),
      });
    }

    return transformedProperties;
  }
}
