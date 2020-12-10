import 'package:equatable/equatable.dart';
import 'package:example/data/repository/authentication_repository.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;

  AuthenticationStatusChanged({this.status});

  @override
  List<Object> get props => [status];
}

class AuthenticationLogOutRequested extends AuthenticationEvent {}
