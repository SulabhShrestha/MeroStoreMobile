class UrlsConstant {
  String get _localUrl => "http://10.0.2.2:3000";

  Map<String, String> get headers => {"Content-Type": "application/json"};

  // stock related
  String get addStockUrl => "$_localUrl/instock/add";
  String get allStocksUrl => "$_localUrl/instock/";
  String get allMaterialNamesUrl => "$_localUrl/instock/materialNames";
  String get materialDetailsUrl => "$_localUrl/instock/materialDetails";

  // sales related
  String get allSalesUrl => "$_localUrl/sales/";
  String get addSalesUrl => "$_localUrl/sales/add";

  // stores related
  String get allStoresUrl => "$_localUrl/store/";
  String get addStoreUrl => "$_localUrl/store/add";
}
