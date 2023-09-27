import 'package:flutter/material.dart';

class MessagesConstant {
  String get missingRequiredFields => "Please fill all the required fields.";
  String get invalidQuantity => "Please enter a valid quantity.";
  String get invalidPrice => "Please enter a valid price.";

  String get somethingWentWrong => "Something went wrong.";

  String get materialNotFound => "Material not found.";

  String get soldQuantityExceeded => "Not enough stocks.";

  StoreRelatedMessages get storeRelatedMessages => StoreRelatedMessages();
}

/// Messages related to store
class StoreRelatedMessages {
  String get storeNameNotEntered => "Store name not entered.";
  String get transactionTypesNotSelected => "Transaction types not selected.";
  String get quantityTypesNotSelected => "Quantity types not selected.";
  String get storeAlreadyAdded => "Store already added.";
}
