import 'package:merostore_mobile/models/user_info.dart';
import 'package:riverpod/riverpod.dart';

final userProvider = Provider<UserInfo>((ref) {
  return UserInfo();
});
