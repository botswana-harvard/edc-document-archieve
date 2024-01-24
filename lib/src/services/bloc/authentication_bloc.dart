import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:edc_document_archieve/src/providers/authentication_provider.dart';
import 'package:edc_document_archieve/src/utils/enums.dart';
import 'package:equatable/equatable.dart';
part 'events/authentication_event.dart';
part 'states/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationProvider authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(AuthenticationState.unknown()) {
    on<AuthenticationLogoutRequested>(
      _onAuthenticationLogoutRequested,
      transformer: sequential(),
    );
    on<AuthenticationLoginSubmitted>(
      _onLoginSubmitted,
      transformer: sequential(),
    );
  }

  final AuthenticationProvider _authenticationRepository;

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  Future<void> _onLoginSubmitted(
    AuthenticationLoginSubmitted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationState.loading());
    await _authenticationRepository.login(
        username: event.username, password: event.password);

    switch (_authenticationRepository.authStatus) {
      case AuthenticationStatus.authenticated:
        emit(AuthenticationState.authenticated());
        break;
      default:
        emit(AuthenticationState.unauthenticated(
            _authenticationRepository.error));
    }
  }

  String lastAccountLoggedIn() {
    try {
      final String user = _authenticationRepository.lastUserAccountLoggedIn();
      return user;
    } catch (_) {
      return '';
    }
  }
}
