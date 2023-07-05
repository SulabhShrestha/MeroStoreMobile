import 'package:merostore_mobile/services/user_web_services.dart';

class UserViewModel {
  Future<void> loginWithGoogle() async {
    await UserWebServices().loginWithGoogle();
  }
}
