import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';

// Helper class responsible for assisting [StockPage]
class StockHelper {
  Widget getNormalHeading(String text) {
    return Text(
      "$text:",
      style: const TextStyle(
        color: ConstantAppColors.secondaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }

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
        "heading": "Creditor Name",
        "required": true,
      },
      {
        "heading": "Creditor Information",
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
        "heading": "Debtor Name",
        "required": true,
      },
      {
        "heading": "Debtor Information",
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
        "heading": "Return Quantity",
        "required": true,
        "quantityOption": true,
      },
      {
        "heading": "Return Amount",
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
