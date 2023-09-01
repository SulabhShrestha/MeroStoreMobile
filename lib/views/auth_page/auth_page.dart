import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:merostore_mobile/view_models/local_storage_view_model.dart';
import 'package:merostore_mobile/view_models/user_view_model.dart';
import 'package:merostore_mobile/views/root_page/root_page.dart';

/// Authentication page
///

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: LocalStorageViewModel().getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            log("snapshot.hasData: ${snapshot.data}");
            if (snapshot.data!.isNotEmpty) {
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Some error occured"),
                        ),
                      );
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
