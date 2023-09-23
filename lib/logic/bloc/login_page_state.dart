part of 'login_page_bloc.dart';

@JsonSerializable()
class LoginPageState extends Equatable {

  const LoginPageState({
    this.progress = SubmissionProgress.initial,
    this.status = VerifyStatus.empty,
    this.studentId = const StudentId.pure(),
    this.password = const Password.pure(),
  });
  
  @JsonKey(includeToJson: false, includeFromJson: false)
  final StudentId studentId;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final Password password;

  final VerifyStatus status;
  final SubmissionProgress progress;

  factory LoginPageState.fromJson(Map<String, dynamic> json) =>
      _$LoginPageStateFromJson(json);

  Map<String, dynamic> toJson() => _$LoginPageStateToJson(this);

  LoginPageState copyWith({
    VerifyStatus? status,
    SubmissionProgress? progress,
    StudentId? studentId,
    Password? password,
  }) {
    return LoginPageState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      studentId: studentId ?? this.studentId,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, progress,studentId, password];
}
