import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/models/store_model.dart';
import 'package:merostore_mobile/providers/store_provider.dart';
import 'package:merostore_mobile/views/core_widgets/custom_card.dart';
import 'package:merostore_mobile/views/store_page/pages/handle_store.dart';

/// This page is responsible for providing interface to edit salesTransactionType,
/// Quantity type and stores.
///

class StorePage extends ConsumerWidget {
  const StorePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stores = ref.watch(storesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stores"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const HandleStore(
                    showEditPage: false,
                  )));
        },
        tooltip: "Add new sales transaction",
        child: const Icon(
          Icons.add,
        ),
      ),
      body: ListView(
        children: [
          for (StoreModel element in stores)
            CustomCard(
              displaying: "Store",
              // id: element.id,
              store: element,
              enableDeleteOption: stores.length == 1 ? false : true,
            ),
        ],
      ),
    );
  }
}
