import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:merostore_mobile/services/local_storage_services.dart';

class UserWebServices {
  Future<void> loginWithGoogle() async {
    log("inside of loginWithGoogle");

    // trying to login with google

    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
    );

    var account = await googleSignIn.signIn();

    LocalStorageServices().saveUserInfo({
      "name": account!.displayName,
      "email": account.email,
      "photoUrl": account.photoUrl,
      "id": account.id,
    });
  }

  Future<void> logout() async {
    await LocalStorageServices().removeUserInfo();
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
  }
}
