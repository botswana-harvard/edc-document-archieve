import 'package:edc_document_archieve/src/core/models/participant_crf.dart';
import 'package:edc_document_archieve/src/core/models/participant_non_crf.dart';
import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/core/models/user_account.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

abstract class LocalStorageRepository {
  late Box appStorageBox;
  late Box userAccountsBox;

  LocalStorageRepository() {
    appStorageBox = Hive.box(kAppStorageBox);
    userAccountsBox = Hive.box(kUserAccountsBox);
  }

  static Future<void> setupLocalStorage() async {
    await Hive.initFlutter();
    var appDir = await getApplicationDocumentsDirectory();
    // Hive.registerAdapter(AppColorsAdapter());
    // Hive.registerAdapter(ThemesAdapter());
    Hive.registerAdapter(UserAccountAdapter());
    Hive.registerAdapter(StudyDocumentAdapter());
    Hive.registerAdapter(ParticipantCrfAdapter());
    Hive.registerAdapter(ParticipantNonCrfAdapter());
    await Hive.openBox(kAppStorageBox, path: appDir.path);
    await Hive.openBox(kUserAccountsBox, path: appDir.path);
  }
}
