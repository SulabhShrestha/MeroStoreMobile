import 'dart:developer';

class StoreModel {
  final String id;
  final String storeName;
  final List<dynamic> quantityTypes;
  final List<dynamic> transactionTypes;

  StoreModel({
    required this.id,
    required this.storeName,
    required this.quantityTypes,
    required this.transactionTypes,
  });

  factory StoreModel.fromJSON(Map<String, dynamic> json) {
    return StoreModel(
      id: json["_id"],
      storeName: json["storeName"],
      quantityTypes: json["quantityTypes"],
      transactionTypes: json["transactionTypes"],
    );
  }

  // Useful for updating current store value
  StoreModel copyWith({
    String? id,
    String? storeName,
    List<dynamic>? quantityTypes,
    List<dynamic>? transactionTypes,
  }) {
    return StoreModel(
      id: id ?? this.id,
      storeName: storeName ?? this.storeName,
      quantityTypes: quantityTypes ?? this.quantityTypes,
      transactionTypes: transactionTypes ?? this.transactionTypes,
    );
  }
}
