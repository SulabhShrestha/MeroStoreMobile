/// Helper class responsible for assisting [StockPage]
class StockHelper {
  List<String> getTransactionTypes() {
    return ["Cash", "Credit", "Prepaid", "Return"];
  }

  List<Map> _getCashInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
      },
      {
        "heading": "Brought Quantity",
        "required": true,
        "quantityOption": true,
      },
      {
        "heading": "Total Price",
        "required": true,
      },
      {
        "heading": "Description",
        "required": false,
      },
    ];
  }

  List<Map> _getCreditInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
      },
      {
        "heading": "Brought Quantity",
        "required": true,
        "quantityOption": true,
      },
      {
        "heading": "Total Price",
        "required": true,
      },
      {
        "heading": "Creditor's Name",
        "required": true,
      },
      {
        "heading": "Creditor's Information",
        "required": false,
      },
      {
        "heading": "Description",
        "required": false,
      },
    ];
  }

  List<Map> _getPrepaidInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
      },
      {
        "heading": "For Quantity",
        "required": true,
        "quantityOption": true,
      },
      {
        "heading": "Money Given",
        "required": true,
      },
      {
        "heading": "Debtor's Name",
        "required": true,
      },
      {
        "heading": "Debtor's Information",
        "required": false,
      },
      {
        "heading": "Description",
        "required": false,
      },
    ];
  }

  List<Map> _getReturnInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
      },
      {
        "heading": "Returned Quantity",
        "required": true,
        "quantityOption": true,
      },
      {
        "heading": "Returned Amount",
        "required": true,
      },
      {
        "heading": "Description",
        "required": false,
      },
    ];
  }

  List<Map> getInformation({required String transactionType}) {
    switch (transactionType.toLowerCase()) {
      case "cash":
        return _getCashInformation();

      case "credit":
        return _getCreditInformation();

      case "prepaid":
        return _getPrepaidInformation();

      case "return":
        return _getReturnInformation();

      default:
        return [];
    }
  }
}
