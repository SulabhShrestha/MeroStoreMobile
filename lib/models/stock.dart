class Stock {
  final String id;
  final String transactionType;
  final Map<String, dynamic> details;

  Stock(
      {required this.id, required this.transactionType, required this.details});

  factory Stock.fromJSON(Map<String, dynamic> json) {
    return Stock(
      id: json["_id"],
      transactionType: json["transactionType"],
      details: json["details"],
    );
  }
}
