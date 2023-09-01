import 'dart:convert';
import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:merostore_mobile/services/local_storage_services.dart';
import 'package:http/http.dart' as http;
import 'package:merostore_mobile/utils/constants/urls_constant.dart';

class UserWebServices {
  Future<void> loginWithGoogle() async {
    log("inside of loginWithGoogle");

    // trying to login with google
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
    );

    var account = await googleSignIn.signIn();

    Map<String, dynamic> userDetails = {
      "name": account!.displayName,
      "email": account.email,
      "photoUrl": account.photoUrl,
      "uid": account.id,
    };

    // saving remotely and locally
    log("Before adding: $userDetails");
    await addToDB(userDetails);
    await LocalStorageServices().saveUserInfo(userDetails);
  }

  // adds user info to the db
  Future<void> addToDB(Map<String, dynamic> userDetails) async {
    var urlsConstant = UrlsConstant();
    var response = await http.post(
      Uri.parse(urlsConstant.addUserUrl),
      headers: urlsConstant.headers,
      body: jsonEncode(userDetails),
    );

    if (response.statusCode != 201) {
      log("Something went wrong. ${response.reasonPhrase}");
    }
  }

  Future<void> logout() async {
    await LocalStorageServices().removeUserInfo();
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
  }
}
