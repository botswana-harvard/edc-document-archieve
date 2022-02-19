import 'package:edc_document_archieve/src/api/auth_api.dart';
import 'package:edc_document_archieve/src/api/repository/auth_repository.dart';
import 'package:edc_document_archieve/src/services/auth_service.dart';
import 'package:kiwi/kiwi.dart';

part 'injector.g.dart';

abstract class Injector {
  static late KiwiContainer container;

  void _configure() {
    container = KiwiContainer();
    _configureAuthServiceModuleFactories();
  }

  @Register.factory(AuthService)
  @Register.factory(AuthRepository, from: AuthAPI)
  @Register.singleton(AuthAPI)
  void _configureAuthServiceModuleFactories();

  static final resolve = container.resolve;

  static void setup() {
    _$Injector()._configure();
  }
}
