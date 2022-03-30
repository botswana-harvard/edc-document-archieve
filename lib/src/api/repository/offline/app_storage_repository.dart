import 'package:edc_document_archieve/src/api/repository/offline/local_storage_repository.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';

class AppStorageRepository extends LocalStorageRepository {
  /// Saves cookies to local storage
  String setCookies(String cookies) {
    appStorageBox.put(kCookies, cookies);
    return cookies;
  }

  /// Retrive cookie
  String getCookies() {
    String _savedCookies = appStorageBox.get(kCookies, defaultValue: '');
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
