import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:example/screens/register_1/models/register_model.dart';
import 'bloc.dart';

class Register1Bloc extends Bloc<Register1Event, Register1State> {
  Register1Bloc() : super(Register1Initial());

  @override
  Stream<Register1State> mapEventToState(
    Register1Event event,
  ) async* {
    if (event is Register1ConfirmEvent) {
      RegisterModel value =
          RegisterModel(email: event.email, password: event.password);
      if (value.email.isNotEmpty && value.password.isNotEmpty) {
        yield Register1Success(registerModel: value);
      } else {
        yield Register1Failed();
      }
    }
  }
}
