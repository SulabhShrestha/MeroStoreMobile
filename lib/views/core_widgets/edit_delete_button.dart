/// This button helps to edit and delete a record
///

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/providers/store_provider.dart';
import 'package:merostore_mobile/view_models/store_view_model.dart';
import 'package:merostore_mobile/views/store_page/pages/handle_store.dart';

import 'snackbar_message.dart';

class EditDeleteButton extends ConsumerWidget {
  final String id;
  final bool enableDeleteOption;

  const EditDeleteButton({
    super.key,
    required this.id,
    required this.enableDeleteOption,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onTap: () async {
                  // Navigating to edit store page
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => HandleStore(
                            showEditPage: true,
                            store: ref
                                .read(storesProvider.notifier)
                                .getStoreById(id),
                          )));
                },
              ),
              PopupMenuItem(
                enabled: enableDeleteOption,
                onTap: () {
                  StoreViewModel().deleteStore(id: id).then((value) {
                    // removing store from the cached store list
                    ref.read(storesProvider.notifier).deleteStore(id);

                    // displaying information
                    SnackBarMessage().showMessage(context, "Deleted successfully");

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
