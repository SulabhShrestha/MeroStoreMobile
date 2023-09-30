import 'package:merostore_mobile/models/store_model.dart';

class Sales {
  final String id;
  final String transactionType;
  final StoreModel storeModel;
  final Map<String, dynamic> details;

  Sales({
    required this.id,
    required this.transactionType,
    required this.storeModel,
    required this.details,
  });

  factory Sales.fromJSON(Map<String, dynamic> json) {
    return Sales(
      id: json["_id"],
      transactionType: json["transactionType"],
      storeModel: StoreModel.fromJSON(json["storeId"]),
      details: json["details"],
    );
  }
}
