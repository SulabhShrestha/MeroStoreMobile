import 'package:merostore_mobile/models/store_model.dart';

class StockModel {
  final String id;
  final String transactionType;
  final String storeName;
  final StoreModel storeModel;
  final Map<String, dynamic> details;

  StockModel({
    required this.id,
    required this.transactionType,
    required this.storeName,
    required this.storeModel,
    required this.details,
  });

  factory StockModel.fromJSON(Map<String, dynamic> json) {
    return StockModel(
      id: json["_id"],
      transactionType: json["transactionType"],
      storeName: json["storeId"]["storeName"],
      storeModel: StoreModel.fromJSON(json["storeId"]),
      details: json["details"],
    );
  }

  // Useful for updating current store value
  StockModel copyWith({
    String? id,
    String? transactionType,
    String? storeName,
    StoreModel? storeModel,
    Map<String, dynamic>? details,
  }) {
    return StockModel(
      id: id ?? this.id,
      transactionType: transactionType ?? this.transactionType,
      storeName: storeName ?? this.storeName,
      storeModel: storeModel ?? this.storeModel,
      details: details ?? this.details,
    );
  }
}
