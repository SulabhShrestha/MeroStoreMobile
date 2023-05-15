import 'package:flutter/material.dart';
import 'package:merostore_mobile/views/edit_store_page/widgets/add_new_store.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(
        children: [
          // Add new store
          Positioned(
            right: 16,
            bottom: 16,
            child: AnimatedContainer(
              width: 58,
              height: 58,
              duration: const Duration(milliseconds: 250),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AddNewStore()));
                },
                tooltip: "Add new sales transaction",
                child: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
