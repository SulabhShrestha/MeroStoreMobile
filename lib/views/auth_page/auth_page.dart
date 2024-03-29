import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merostore_mobile/providers/user_provider.dart';
import 'package:merostore_mobile/view_models/local_storage_view_model.dart';
import 'package:merostore_mobile/view_models/user_view_model.dart';
import 'package:merostore_mobile/views/core_widgets/snackbar_message.dart';
import 'package:merostore_mobile/views/root_page/root_page.dart';

/// Authentication page
///

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder(
        future: LocalStorageViewModel().getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            log("snapshot.hasData: ${snapshot.data}");
            if (snapshot.data!.isNotEmpty) {
              // log("inside auth: ${snapshot.data}");
              ref.watch(userProvider).add(snapshot.data!);
              return const RootPage();
            } else {
              return Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await UserViewModel().loginWithGoogle().then((value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RootPage(),
                        ),
                      );
                    }).onError((error, stackTrace) {
                      log(error.toString());
                      SnackBarMessage()
                          .showMessage(context, "Some error occurred");
                    });
                  },
                  child: const Text("Login with Google"),
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
