import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;
@injectableInit
void configureInjection(String environment) =>
    $initGetIt(getIt, environment: environment);
