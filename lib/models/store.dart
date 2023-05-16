import 'dart:developer';

class Store {
  final String id;
  final String storeName;
  final List<dynamic> quantityTypes;
  final List<dynamic> transactionTypes;

  Store({
    required this.id,
    required this.storeName,
    required this.quantityTypes,
    required this.transactionTypes,
  });

  factory Store.fromJSON(Map<String, dynamic> json) {
    log("Json: $json");
    return Store(
      id: json["_id"],
      storeName: json["storeName"],
      quantityTypes: json["quantityTypes"],
      transactionTypes: json["transactionTypes"],
    );
  }
}
