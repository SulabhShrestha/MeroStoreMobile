/// This button helps to edit and delete a record
///

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:merostore_mobile/models/stores_model.dart';
import 'package:merostore_mobile/view_models/store_view_model.dart';
import 'package:provider/provider.dart';

class EditDeleteButton extends StatelessWidget {
  final String id;
  final bool enableDeleteOption;

  const EditDeleteButton({
    super.key,
    required this.id,
    required this.enableDeleteOption,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PopupMenuButton(
          shape: const OutlineInputBorder(),
          position: PopupMenuPosition.under,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.more_vert,
              color: Colors.grey,
            ),
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: const Text('Edit'),
                onTap: () async {},
              ),
              PopupMenuItem(
                enabled: enableDeleteOption,
                onTap: () {
                  StoreViewModel().deleteStore(id: id).then((value) {
                    // removing store from the cached store list
                    context.read<Stores>().deleteStore(id);

                    // displaying information
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Deleted successfully")));
                  });
                },
                child: const Text('Delete'),
              ),
            ];
          },
        ),
      ],
    );
  }
}
