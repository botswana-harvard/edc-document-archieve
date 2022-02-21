import 'package:edc_document_archieve/src/api/repository/offline/authentication_offline_repository.dart';
import 'package:edc_document_archieve/src/api/repository/offline/local_storage_repository.dart';
import 'package:edc_document_archieve/src/api/repository/online/authentication_online_repository.dart';
import 'package:edc_document_archieve/src/api/wrapper/authentication_wrapper.dart';
import 'package:edc_document_archieve/src/providers/authentication_provider.dart';
import 'package:edc_document_archieve/src/services/bloc/authentication_bloc.dart';
import 'package:kiwi/kiwi.dart';

part 'injector.g.dart';

abstract class Injector {
  static late KiwiContainer container;

  void _configure() {
    container = KiwiContainer();
    _configureAuthServiceModuleFactories();
    _configureAppServiceModuleSingletons();
  }

  @Register.factory(AuthenticationBloc)
  @Register.factory(AuthenticationProvider, from: AuthenticationWrapper)
  void _configureAuthServiceModuleFactories();

  @Register.singleton(AuthenticationOfflineRepository)
  @Register.singleton(AuthenticationOnlineRepository)
  @Register.singleton(AuthenticationWrapper)
  void _configureAppServiceModuleSingletons();

  static final resolve = container.resolve;

  static void setup() {
    _$Injector()._configure();
  }
}
