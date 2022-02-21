import 'package:edc_document_archieve/src/api/repository/authentication_repository.dart';
import 'package:edc_document_archieve/src/providers/authentication_provider.dart';
import 'package:edc_document_archieve/src/services/bloc/authentication_bloc.dart';
import 'package:kiwi/kiwi.dart';

part 'injector.g.dart';

abstract class Injector {
  static late KiwiContainer container;

  void _configure() {
    container = KiwiContainer();
    _configureAuthServiceModuleFactories();
  }

  @Register.factory(AuthenticationBloc)
  @Register.factory(AuthenticationProvider, from: AuthenticationRepository)
  @Register.singleton(AuthenticationRepository)
  void _configureAuthServiceModuleFactories();

  static final resolve = container.resolve;

  static void setup() {
    _$Injector()._configure();
  }
}
