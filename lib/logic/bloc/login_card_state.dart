part of 'login_card_bloc.dart';

class LoginCardState extends Equatable {
  const LoginCardState({
    this.status = VerifyStatus.empty,
    this.studentId = const StudentId.pure(),
    this.password = const Password.pure(),
  });

  final VerifyStatus status;
  final StudentId studentId;
  final Password password;

  LoginCardState copyWith({
    VerifyStatus? status,
    StudentId? studentId,
    Password? password,
  }) {
    return LoginCardState(
      status: status ?? this.status,
      studentId: studentId ?? this.studentId,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, studentId, password];
}
