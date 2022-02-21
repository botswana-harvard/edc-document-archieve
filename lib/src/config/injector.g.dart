// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void configureDAServiceModuleFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => DocumentArchieveBloc(
          documentArchieveRepository: c<DocumentArchieveProvider>()))
      ..registerFactory<DocumentArchieveProvider>(
          (c) => DocumentArchieveWrapper());
  }

  @override
  void configureAuthServiceModuleFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => AuthenticationBloc(
          authenticationRepository: c<AuthenticationProvider>()))
      ..registerFactory<AuthenticationProvider>((c) => AuthenticationWrapper());
  }

  @override
  void configureAuthServiceModuleSingletons() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => AuthenticationOfflineRepository())
      ..registerSingleton((c) => AuthenticationOnlineRepository())
      ..registerSingleton((c) => AuthenticationWrapper());
  }

  @override
  void configureDAServiceModuleSingletons() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => DocumentArchieveOffLineRepository())
      ..registerSingleton((c) => DocumentArchieveOnLineRepository())
      ..registerSingleton((c) => DocumentArchieveWrapper());
  }
}
