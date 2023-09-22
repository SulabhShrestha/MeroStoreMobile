import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:merostore_mobile/models/stores_model.dart';
import 'package:merostore_mobile/utils/constants/messages_constant.dart';
import 'package:merostore_mobile/view_models/store_view_model.dart';
import 'package:merostore_mobile/views/store_page/widgets/dynamic_checkbox_list.dart';

/// Responsible for providing both edit and adding new store widget
class HandleStore extends StatefulWidget {
  final Stores stores; // For adding new store locally

  // if edit store page to be displayed
  final bool showEditPage;

  const HandleStore({
    Key? key,
    this.showEditPage = false,
    required this.stores,
  }) : super(key: key);

  @override
  State<HandleStore> createState() => _HandleStoreState();
}

class _HandleStoreState extends State<HandleStore> {
  List<String> userSelectedTransactionTypes = [];
  List<String> userSelectedQuantityTypes = [];

  final _storeNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.showEditPage) {
      return _showEditStore();
    }
    return _showAddNewStore();
  }

  // Displays editing old store widget
  Widget _showEditStore() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit store"),
        actions: [
          TextButton(
            onPressed: () {
              if (_storeNameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                    MessagesConstant().storeRelatedMessages.storeNameNotEntered,
                  )),
                );
              } else if (userSelectedTransactionTypes.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                    MessagesConstant()
                        .storeRelatedMessages
                        .transactionTypesNotSelected,
                  )),
                );
              } else if (userSelectedQuantityTypes.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                    MessagesConstant()
                        .storeRelatedMessages
                        .quantityTypesNotSelected,
                  )),
                );
              }
              // checking if previously entered
              else if (Stores()
                  .contains(_storeNameController.text.trim().capitalize())) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(MessagesConstant()
                          .storeRelatedMessages
                          .storeAlreadyAdded)),
                );
              } else {
                Map<String, dynamic> newStoreDetails = {
                  "storeName": _storeNameController.text.trim().capitalize(),
                  "quantityTypes": userSelectedQuantityTypes,
                  "transactionTypes": userSelectedTransactionTypes,
                };

                log(newStoreDetails.toString());

                StoreViewModel().addNewStore(
                  newStore: newStoreDetails,
                  onStockAdded: (addedStore) {
                    // Adding newly added store to the stores list
                    widget.stores.addStore(addedStore);
                    log("Newly added store: $addedStore");

                    Navigator.of(context).pop();
                  },
                  onFailure: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(MessagesConstant().somethingWentWrong)),
                    );
                  },
                );
              }
            },
            child: const Icon(Icons.check, color: Colors.white),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            _textFieldWithLabel(),
            DynamicCheckboxList(
              heading: "Transaction types",
              options: const [
                'Cash',
                'Credit',
                'Prepaid',
                "Return",
                "Settlement",
                "Deposited",
              ],
              showOtherOption: false,
              onSelectOptionsChanged: (value) {
                log("transaction: $value");
                userSelectedTransactionTypes = value;
              },
            ),
            DynamicCheckboxList(
              heading: "Quantity types",
              options: const ['Kg', 'Pcs', 'Litre', "Box", "Sack"],
              showOtherOption: true,
              onSelectOptionsChanged: (value) {
                log("quantity: $value");
                userSelectedQuantityTypes = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  // Displays adding new store widget
  Widget _showAddNewStore() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new store"),
        actions: [
          TextButton(
            onPressed: () {
              if (_storeNameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                    MessagesConstant().storeRelatedMessages.storeNameNotEntered,
                  )),
                );
              } else if (userSelectedTransactionTypes.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                    MessagesConstant()
                        .storeRelatedMessages
                        .transactionTypesNotSelected,
                  )),
                );
              } else if (userSelectedQuantityTypes.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                    MessagesConstant()
                        .storeRelatedMessages
                        .quantityTypesNotSelected,
                  )),
                );
              }
              // checking if previously entered
              else if (Stores()
                  .contains(_storeNameController.text.trim().capitalize())) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(MessagesConstant()
                          .storeRelatedMessages
                          .storeAlreadyAdded)),
                );
              } else {
                Map<String, dynamic> newStoreDetails = {
                  "storeName": _storeNameController.text.trim().capitalize(),
                  "quantityTypes": userSelectedQuantityTypes,
                  "transactionTypes": userSelectedTransactionTypes,
                };

                log(newStoreDetails.toString());

                StoreViewModel().addNewStore(
                  newStore: newStoreDetails,
                  onStockAdded: (addedStore) {
                    // Adding newly added store to the stores list
                    widget.stores.addStore(addedStore);
                    log("Newly added store: $addedStore");

                    Navigator.of(context).pop();
                  },
                  onFailure: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(MessagesConstant().somethingWentWrong)),
                    );
                  },
                );
              }
            },
            child: const Icon(Icons.check, color: Colors.white),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            _textFieldWithLabel(),
            DynamicCheckboxList(
              heading: "Transaction types",
              options: const [
                'Cash',
                'Credit',
                'Prepaid',
                "Return",
                "Settlement",
                "Deposited",
              ],
              showOtherOption: false,
              onSelectOptionsChanged: (value) {
                log("transaction: $value");
                userSelectedTransactionTypes = value;
              },
            ),
            DynamicCheckboxList(
              heading: "Quantity types",
              options: const ['Kg', 'Pcs', 'Litre', "Box", "Sack"],
              showOtherOption: true,
              onSelectOptionsChanged: (value) {
                log("quantity: $value");
                userSelectedQuantityTypes = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFieldWithLabel() {
    return Row(
      children: [
        const Text("Store Name: "),
        Expanded(
          child: TextField(
            controller: _storeNameController,
          ),
        ),
      ],
    );
  }
}
