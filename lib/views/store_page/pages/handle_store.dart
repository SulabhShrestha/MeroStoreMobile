import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:merostore_mobile/models/store_model.dart';
import 'package:merostore_mobile/models/stores_model.dart';
import 'package:merostore_mobile/utils/constants/messages_constant.dart';
import 'package:merostore_mobile/view_models/store_view_model.dart';
import 'package:merostore_mobile/views/store_page/widgets/dynamic_checkbox_list.dart';
import 'package:provider/provider.dart';

/// Responsible for providing both edit and adding new store widget
class HandleStore extends StatefulWidget {
  // if edit store page to be displayed
  final bool showEditPage;

  // if edit store page to be displayed, then store object must be passed
  final Store? store;

  // for updating store
  final Stores? stores;

  const HandleStore({
    Key? key,
    this.showEditPage = false,
    this.store,
    this.stores,
  }) : super(key: key);

  @override
  State<HandleStore> createState() => _HandleStoreState();
}

class _HandleStoreState extends State<HandleStore> {
  List<dynamic> userSelectedTransactionTypes = [];
  List<dynamic> userSelectedQuantityTypes = [];

  final _storeNameController = TextEditingController();

  @override
  void initState() {
    // adding default value to field when
    _storeNameController.text = widget.store?.storeName ?? "";
    userSelectedTransactionTypes = widget.store?.transactionTypes ?? [];
    userSelectedQuantityTypes = widget.store?.quantityTypes ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showEditPage) {
      return _showEditStore();
    }
    return _showAddNewStore();
  }

  @override
  void dispose() {
    log("${_storeNameController.text}, $userSelectedQuantityTypes, $userSelectedTransactionTypes");
    super.dispose();
  }

  // true means everything's perfect, can be added to the db
  bool _validateInputData() {
    if (_storeNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          MessagesConstant().storeRelatedMessages.storeNameNotEntered,
        )),
      );
      return false;
    } else if (userSelectedTransactionTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          MessagesConstant().storeRelatedMessages.transactionTypesNotSelected,
        )),
      );
      return false;
    } else if (userSelectedQuantityTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          MessagesConstant().storeRelatedMessages.quantityTypesNotSelected,
        )),
      );
      return false;
    }

    return true;
  }

  // Displays editing old store widget
  Widget _showEditStore() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit store"),
        actions: [
          TextButton(
            onPressed: () {
              if (!_validateInputData()) {
                return;
              }
              Map<String, dynamic> updateStoreDetails = {
                "storeName": _storeNameController.text.trim().capitalize(),
                "quantityTypes": userSelectedQuantityTypes,
                "transactionTypes": userSelectedTransactionTypes,
              };

              log(updateStoreDetails.toString());

              StoreViewModel()
                  .updateStore(
                      id: widget.store!.id, updatedStore: updateStoreDetails)
                  .then((value) {
                widget.stores!.updateStoreById(
                    id: widget.store!.id, data: updateStoreDetails);
                Navigator.of(context).pop();
              }).onError((error, stackTrace) {
                log(error.toString());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(MessagesConstant().somethingWentWrong)),
                );
              });
            },
            child: const Icon(Icons.check, color: Colors.white),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            _textFieldWithLabel(storeName: widget.store!.storeName),
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
              selectedOptions: widget.store!.transactionTypes,
            ),
            DynamicCheckboxList(
              heading: "Quantity types",
              options: const ['Kg', 'Pcs', 'Litre', "Box", "Sack"],
              showOtherOption: true,
              onSelectOptionsChanged: (value) {
                log("quantity: $value");
                userSelectedQuantityTypes = value;
              },
              selectedOptions: widget.store!.quantityTypes,
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
              if (!_validateInputData()) {
                return;
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
                    Provider.of<Stores>(context).addStore(addedStore);

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

  Widget _textFieldWithLabel({String? storeName}) {
    return Row(
      children: [
        const Text("Store Name: "),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: storeName ?? "",
            ),
            controller: _storeNameController,
          ),
        ),
      ],
    );
  }
}
