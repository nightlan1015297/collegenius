part of 'login_page_bloc.dart';

class LoginPageState extends Equatable {
  const LoginPageState({
    this.status = FormzStatus.pure,
    this.studentId = const StudentId.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final StudentId studentId;
  final Password password;

  LoginPageState copyWith({
    FormzStatus? status,
    StudentId? studentId,
    Password? password,
  }) {
    return LoginPageState(
      status: status ?? this.status,
      studentId: studentId ?? this.studentId,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, studentId, password];
}
