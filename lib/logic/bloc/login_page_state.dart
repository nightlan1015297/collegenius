part of 'login_page_bloc.dart';

@JsonSerializable()
class LoginPageState extends Equatable {
  const LoginPageState({
    this.status = FormzStatus.pure,
    this.studentId = const StudentId.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  @JsonKey(ignore: true)
  final StudentId studentId;
  @JsonKey(ignore: true)
  final Password password;
  factory LoginPageState.fromJson(Map<String, dynamic> json) =>
      _$LoginPageStateFromJson(json);

  Map<String, dynamic> toJson() => _$LoginPageStateToJson(this);
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
