import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:kiwi/kiwi.dart';
import 'index.dart';

part 'injector.g.dart';

abstract class Injector {
  static late KiwiContainer container;

  void _configure() {
    container = KiwiContainer();

    _configureDAServiceModuleFactories();
    _configureAuthServiceModuleFactories();

    _configureDAServiceModuleSingletons();
    _configureAuthServiceModuleSingletons();
  }

  static final resolve = container.resolve;

  static void setup() {
    _$Injector()._configure();
  }

  @Register.factory(DocumentArchieveBloc)
  @Register.factory(DocumentArchieveProvider, from: DocumentArchieveWrapper)
  void _configureDAServiceModuleFactories();

  @Register.factory(AuthenticationBloc)
  @Register.factory(AuthenticationProvider, from: AuthenticationWrapper)
  void _configureAuthServiceModuleFactories();

  @Register.singleton(AuthenticationOfflineRepository)
  @Register.singleton(AuthenticationOnlineRepository)
  @Register.singleton(AuthenticationWrapper)
  void _configureAuthServiceModuleSingletons();

  @Register.singleton(DocumentArchieveOffLineRepository)
  @Register.singleton(DocumentArchieveOnLineRepository)
  @Register.singleton(DocumentArchieveWrapper)
  void _configureDAServiceModuleSingletons();
}
