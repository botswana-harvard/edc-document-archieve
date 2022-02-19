import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  late Box appStorageBox;
  late Box userAccountsBox;

  LocalStorageService() {
    appStorageBox = Hive.box(kAppStorageBox);
    userAccountsBox = Hive.box(kUserAccountsBox);
  }

  static Future setupLocalStorage() async {
    await Hive.initFlutter();
    var appDir = await getApplicationDocumentsDirectory();
    // Hive.registerAdapter(AppColorsAdapter());
    // Hive.registerAdapter(ThemesAdapter());
    // Hive.registerAdapter(UserAccountAdapter());
    await Hive.openBox(kAppStorageBox, path: appDir.path);
    await Hive.openBox(kUserAccountsBox, path: appDir.path);
  }

  /// Saves cookies to local storage
  String setCookies(String cookies) {
    appStorageBox.put(kCookies, cookies);
    return cookies;
  }

  /// Retrive cookie
  String getCookies() {
    String _savedCookies = appStorageBox.get(kCookies);
    return _savedCookies;
  }

  /// Saves CSRFToken to local storage
  String setCSRFToken(String cookie) {
    String _token;
    return cookie;
  }

  /// Retrive CSRFToken
  String getCSRFToken() {
    String _token;
    return '';
  }
}
