/// This button helps to edit and delete a record
///

import 'package:flutter/material.dart';

class EditDeleteButton extends StatelessWidget {
  const EditDeleteButton({super.key});

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
                child: const Text('Delete'),
                onTap: () {},
              ),
            ];
          },
        ),
      ],
    );
  }
}
