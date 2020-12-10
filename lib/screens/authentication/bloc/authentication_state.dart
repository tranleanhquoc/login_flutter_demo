import 'package:equatable/equatable.dart';
import 'package:example/data/repository/authentication_repository.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  const AuthenticationState._({this.status = AuthenticationStatus.unknown});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated()
      : this._(status: AuthenticationStatus.authenticated);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status];
}
