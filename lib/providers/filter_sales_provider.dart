import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/extensions/string_extensions.dart';
import 'package:merostore_mobile/models/sales_model.dart';
import 'package:merostore_mobile/providers/today_sales_provider.dart';
import 'package:merostore_mobile/views/today_sold_page/utils/sales_helper.dart';
import 'currently_selected_store_provider.dart';

/// Uses [todaySalesProvider] to provided sales filtered using the store name
final filteredSalesProvider =
    StateNotifierProvider<FilteredSalesNotifier, List<SalesModel>>((ref) {
  return FilteredSalesNotifier(ref);
});

class FilteredSalesNotifier extends StateNotifier<List<SalesModel>> {
  final Ref _ref;

  FilteredSalesNotifier(this._ref) : super([]);

  /// filters the stocks based on store name
  void filterSales({String? sortingHeading, bool? sortAscending}) {
    final selectedStore = _ref.read(currentlySelectedStoreProvider);
    final allSales = _ref.read(todaySalesProvider);

    if (sortingHeading != null) {
      if (sortAscending == true) {
        allSales.sort((a, b) => (a.details[sortingHeading] ?? "")
            .compareTo(b.details[sortingHeading] ?? ""));
      } else {
        allSales.sort((a, b) => (b.details[sortingHeading] ?? "")
            .compareTo(a.details[sortingHeading] ?? ""));
      }
    }

    String selectedStoreName = selectedStore["stock"];

    // Filter stocks based on the selected store
    final filteredSales = allSales
        .where((sales) =>
            sales.storeModel.storeName.toLowerCase() ==
            selectedStoreName.toLowerCase())
        .toList();

    state = filteredSales;
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
      if (SalesHelper().getBlacklistedHeading().contains(propertyName)) {
        continue;
      }
      transformedProperties.add({
        "heading": propertyName.camelCaseToWords(),
        "fieldName": propertyName,
        "numeric": SalesHelper()
            .getHeadingContainingNumericValue()
            .contains(propertyName),
      });
    }

    return transformedProperties;
  }
}
