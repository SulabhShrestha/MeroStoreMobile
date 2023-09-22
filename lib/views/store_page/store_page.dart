import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:merostore_mobile/models/store_model.dart';
import 'package:merostore_mobile/models/stores_model.dart';
import 'package:merostore_mobile/views/core_widgets/custom_card.dart';
import 'package:merostore_mobile/views/store_page/pages/handle_store.dart';
import 'package:provider/provider.dart';

/// This page is responsible for providing interface to edit salesTransactionType,
/// Quantity type and stores.
///

class StorePage extends StatelessWidget {
  const StorePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stores"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => HandleStore(
                    stores: Provider.of<Stores>(context),
                    showEditPage: false,
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
                  id: element.id,
                  storeName: element.storeName,
                  quantityTypes: element.quantityTypes,
                  transactionTypes: element.transactionTypes,
                  enableDeleteOption:
                      stores.allStores.length == 1 ? false : true,
                ),
            ],
          );
        },
      ),
    );
  }
}
