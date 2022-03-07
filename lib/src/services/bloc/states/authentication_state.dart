part of '../authentication_bloc.dart';

// ignore: must_be_immutable
class AuthenticationState extends Equatable {
  AuthenticationState._(
      {this.status = AuthenticationStatus.unknown, this.error});

  AuthenticationState.unknown() : this._();

  AuthenticationState.authenticated()
      : this._(status: AuthenticationStatus.authenticated);

  AuthenticationState.unauthenticated(String error)
      : this._(status: AuthenticationStatus.unauthenticated, error: error);

  AuthenticationState.loading() : this._(status: AuthenticationStatus.loading);

  final AuthenticationStatus status;
  late String? error;

  @override
  List<Object> get props => [status];
}
