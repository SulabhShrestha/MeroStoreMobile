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
    return Store(
      id: json["_id"],
      storeName: json["storeName"],
      quantityTypes: json["quantityTypes"],
      transactionTypes: json["transactionTypes"],
    );
  }

  // Useful for updating current store value
  Store copyWith({
    String? id,
    String? storeName,
    List<dynamic>? quantityTypes,
    List<dynamic>? transactionTypes,
  }) {
    return Store(
      id: id ?? this.id,
      storeName: storeName ?? this.storeName,
      quantityTypes: quantityTypes ?? this.quantityTypes,
      transactionTypes: transactionTypes ?? this.transactionTypes,
    );
  }
}
