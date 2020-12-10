import 'package:equatable/equatable.dart';

abstract class Register2State extends Equatable {
  const Register2State();

  @override
  List<Object> get props => [];
}

class Register2Initial extends Register2State {}

class Register2Success extends Register2State {}

class Register2Failed extends Register2State {}
