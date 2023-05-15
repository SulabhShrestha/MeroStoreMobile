import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:merostore_mobile/views/edit_store_page/widgets/dynamic_checkbox_list.dart';

class AddNewStore extends StatefulWidget {
  const AddNewStore({Key? key}) : super(key: key);

  @override
  State<AddNewStore> createState() => _AddNewStoreState();
}

class _AddNewStoreState extends State<AddNewStore> {
  List<String> userSelectedTransactionTypes = [];
  List<String> userSelectedQuantityTypes = [];

  final _storeNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new store"),
        actions: [
          TextButton(
            onPressed: () {
              if (_storeNameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Store name not entered.")),
                );
              } else if (userSelectedTransactionTypes.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Transaction types not selected.")),
                );
              } else if (userSelectedQuantityTypes.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Quantity types not selected.")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Everything is fine.")),
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
              onSelectOptionsChanged: (value) {
                log("transaction: $value");
                userSelectedTransactionTypes = value;
              },
            ),
            DynamicCheckboxList(
              heading: "Quantity types",
              options: const ['Kg', 'Pcs', 'Litre', "Box", "Sack"],
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
