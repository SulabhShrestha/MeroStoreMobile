import 'dart:developer';

class StoreModel {
  final String id;
  final String storeName;
  final List<String> quantityTypes;
  final List<String> transactionTypes;

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
      quantityTypes: (json['quantityTypes'] as List)
          .map((item) => item as String)
          .toList(),
      transactionTypes: List<String>.from(json['transactionTypes'] as List),
    );
  }

  // Useful for updating current store value
  StoreModel copyWith({
    String? id,
    String? storeName,
    List<String>? quantityTypes,
    List<String>? transactionTypes,
  }) {
    return StoreModel(
      id: id ?? this.id,
      storeName: storeName ?? this.storeName,
      quantityTypes: quantityTypes ?? this.quantityTypes,
      transactionTypes: transactionTypes ?? this.transactionTypes,
    );
  }

  /// Converts to JSON
  Map<String, dynamic> toJSON() {
    return {
      "_id": id,
      "storeName": storeName,
      "quantityTypes": quantityTypes,
      "transactionTypes": transactionTypes,
    };
  }
}
