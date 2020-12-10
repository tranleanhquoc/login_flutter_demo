import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class Register2Bloc extends Bloc<Register2Event, Register2State> {
  Register2Bloc() : super(Register2Initial());

  @override
  Stream<Register2State> mapEventToState(
    Register2Event event,
  ) async* {
    if (event is Register2ConfirmEvent) {
      if (event.nickname.isNotEmpty) {
        yield Register2Success();
      } else
        yield Register2Failed();
    }
  }
}
