part of 'login_card_bloc.dart';

abstract class LoginCardEvent extends Equatable {
  const LoginCardEvent();

  @override
  List<Object> get props => [];
}

class LoginStudentIdChanged extends LoginCardEvent {
  const LoginStudentIdChanged(this.studentId);

  final String studentId;

  @override
  List<Object> get props => [studentId];
}

class LoginPasswordChanged extends LoginCardEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}
