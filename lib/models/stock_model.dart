class StockModel {
  final String id;
  final String transactionType;
  final String storeName;
  final Map<String, dynamic> details;

  StockModel({
    required this.id,
    required this.transactionType,
    required this.storeName,
    required this.details,
  });

  factory StockModel.fromJSON(Map<String, dynamic> json) {
    return StockModel(
      id: json["_id"],
      transactionType: json["transactionType"],
      storeName: json["storeId"]["storeName"],
      details: json["details"],
    );
  }

  // Useful for updating current store value
  StockModel copyWith({
    String? id,
    String? transactionType,
    String? storeName,
    Map<String, dynamic>? details,
  }) {
    return StockModel(
      id: id ?? this.id,
      transactionType: transactionType ?? this.transactionType,
      storeName: storeName ?? this.storeName,
      details: details ?? this.details,
    );
  }
}
