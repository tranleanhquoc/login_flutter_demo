import 'package:equatable/equatable.dart';
import 'package:example/screens/register_1/models/register_model.dart';

abstract class Register1State extends Equatable {
  const Register1State();

  @override
  List<Object> get props => [];
}

class Register1Initial extends Register1State {}

class Register1Success extends Register1State {
  final RegisterModel registerModel;

  Register1Success({this.registerModel});

  @override
  String toString() => 'RegisterSuccess(registerModel: $registerModel)';

  @override
  List<Object> get props => [registerModel];
}

class Register1Failed extends Register1State {}
