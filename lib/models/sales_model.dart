class Sales {
  final String id;
  final String transactionType;
  final String storeName;
  final Map<String, dynamic> details;

  Sales({
    required this.id,
    required this.transactionType,
    required this.storeName,
    required this.details,
  });

  factory Sales.fromJSON(Map<String, dynamic> json) {
    return Sales(
      id: json["_id"],
      transactionType: json["transactionType"],
      storeName: json["storeName"],
      details: json["details"],
    );
  }
}
