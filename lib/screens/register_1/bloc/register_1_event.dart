import 'package:equatable/equatable.dart';

abstract class Register1Event extends Equatable {
  const Register1Event();

  @override
  List<Object> get props => [];
}

class Register1ConfirmEvent extends Register1Event {
  final String email;
  final String password;

  Register1ConfirmEvent({this.email, this.password});

  @override
  String toString() =>
      'RegisterConfirmEvent(email: $email, password: $password)';

  @override
  List<Object> get props => [email, password];
}
