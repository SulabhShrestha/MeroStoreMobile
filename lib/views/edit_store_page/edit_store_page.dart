import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:merostore_mobile/models/store_model.dart';
import 'package:merostore_mobile/models/stores_model.dart';
import 'package:merostore_mobile/views/core_widgets/custom_card.dart';
import 'package:merostore_mobile/views/edit_store_page/widgets/add_new_store.dart';
import 'package:provider/provider.dart';

/// This page is responsible for providing interface to edit salesTransactionType,
/// Quantity type and stores.
///

class EditStorePage extends StatelessWidget {
  final String title;
  const EditStorePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("Inside edit store: ${Provider.of<Stores>(context)}");
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AddNewStore(
                    stores: Provider.of<Stores>(context, listen: false),
                  )));
        },
        tooltip: "Add new sales transaction",
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Consumer<Stores>(
        builder: (_, stores, __) {
          return ListView(
            children: [
              for (Store element in stores.allStores)
                CustomCard(
                  displaying: "Store",
                  storeName: element.storeName,
                  quantityTypes: element.quantityTypes,
                  transactionTypes: element.transactionTypes,
                ),
            ],
          );
        },
      ),
    );
  }
}
