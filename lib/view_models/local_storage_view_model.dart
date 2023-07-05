import 'package:merostore_mobile/services/local_storage_services.dart';

/// Intermediate between view and the [LocalStorageService]
///
class LocalStorageViewModel {
  /// [LocalStorageService] instance
  final _localStorageService = LocalStorageServices();

  /// Get the user saved information
  Future<Map<String, dynamic>> getUserInfo() async {
    return await _localStorageService.getUserInfo();
  }

  /// Saves the user information
  ///
  Future<void> saveUserInfo(Map<String, dynamic> userMapData) async {
    return await _localStorageService.saveUserInfo(userMapData);
  }

  /// Removes the user information
  Future<void> removeUserInfo() async {
    return await _localStorageService.removeUserInfo();
  }
}
