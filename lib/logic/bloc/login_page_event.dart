part of 'login_page_bloc.dart';

abstract class LoginPageEvent extends Equatable {
  const LoginPageEvent();

  @override
  List<Object> get props => [];
}

class LoginStudentIdChanged extends LoginPageEvent {
  const LoginStudentIdChanged(this.studentId);

  final String studentId;

  @override
  List<Object> get props => [studentId];
}

class LoginPasswordChanged extends LoginPageEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginPageEvent {
  const LoginSubmitted();
}

class LogoutRequst extends LoginPageEvent {
  const LogoutRequst();
}
