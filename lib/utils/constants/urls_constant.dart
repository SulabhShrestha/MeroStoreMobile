import 'package:merostore_mobile/services/local_storage_services.dart';

class UrlsConstant {
  // String get _url => "http://10.0.2.2:3000";
  String get _url => "https://merostore-nodejs.vercel.app";

  Map<String, String> get headers => {"Content-Type": "application/json"};

  // users related
  String get addUserUrl => "$_url/user/create";

  // stock related
  String get addStockUrl => "$_url/instock/add";
  String get allStocksUrl => "$_url/instock/";
  String get allMaterialNamesUrl => "$_url/instock/materialNames";
  String get materialDetailsUrl => "$_url/instock/materialDetails";

  // sales related
  String get allSalesUrl => "$_url/sales/";
  String get addSalesUrl => "$_url/sales/add";

  // stores related
  String get allStoresUrl => "$_url/store/";
  String get addStoreUrl => "$_url/store/add";
}
