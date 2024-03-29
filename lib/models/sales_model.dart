import 'package:merostore_mobile/models/store_model.dart';

class SalesModel {
  final String id;
  final String transactionType;
  final StoreModel storeModel;
  final Map<String, dynamic> details;
  final String createdAt;

  SalesModel({
    required this.id,
    required this.transactionType,
    required this.storeModel,
    required this.details,
    required this.createdAt,
  });

  factory SalesModel.fromJSON(Map<String, dynamic> json) {
    return SalesModel(
      id: json["_id"],
      transactionType: json["transactionType"],
      storeModel: StoreModel.fromJSON(json["storeId"]),
      details: json["details"],
      createdAt: json["createdAt"],
    );
  }

  SalesModel copyWith({
    String? id,
    String? transactionType,
    StoreModel? storeModel,
    Map<String, dynamic>? details,
  }) {
    return SalesModel(
      id: id ?? this.id,
      transactionType: transactionType ?? this.transactionType,
      storeModel: storeModel ?? this.storeModel,
      details: details ?? this.details,
      createdAt: createdAt,
    );
  }
}
