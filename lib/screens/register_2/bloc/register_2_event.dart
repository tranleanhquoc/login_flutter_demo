import 'package:equatable/equatable.dart';

abstract class Register2Event extends Equatable {
  const Register2Event();

  @override
  List<Object> get props => [];
}

class Register2ConfirmEvent extends Register2Event {
  final String nickname;

  Register2ConfirmEvent({this.nickname});

  @override
  String toString() => 'Register2ConfirmEvent(nickname: $nickname)';

  @override
  List<Object> get props => [nickname];
}
