import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;
@injectableInit
void configureInjection(String environment) =>
    $initGetIt(getIt, environment: environment);

class Env {
  static const production = 'production';
  static const testing = 'testing';
  static const development = 'development';
}
