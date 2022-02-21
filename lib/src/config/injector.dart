import 'package:kiwi/kiwi.dart';
import 'index.dart';

part 'injector.g.dart';

abstract class Injector {
  static late KiwiContainer container;

  void _configure() {
    container = KiwiContainer();

    configureDAServiceModuleFactories();
    configureAuthServiceModuleFactories();

    configureDAServiceModuleSingletons();
    configureAuthServiceModuleSingletons();
  }

  static final resolve = container.resolve;

  static void setup() {
    _$Injector()._configure();
  }

  @Register.factory(DocumentArchieveBloc)
  @Register.factory(DocumentArchieveProvider, from: DocumentArchieveWrapper)
  void configureDAServiceModuleFactories();

  @Register.factory(AuthenticationBloc)
  @Register.factory(AuthenticationProvider, from: AuthenticationWrapper)
  void configureAuthServiceModuleFactories();

  @Register.singleton(AuthenticationOfflineRepository)
  @Register.singleton(AuthenticationOnlineRepository)
  @Register.singleton(AuthenticationWrapper)
  void configureAuthServiceModuleSingletons();

  @Register.singleton(DocumentArchieveOffLineRepository)
  @Register.singleton(DocumentArchieveOnLineRepository)
  @Register.singleton(DocumentArchieveWrapper)
  void configureDAServiceModuleSingletons();
}
