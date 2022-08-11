part of 'authentication_bloc.dart';

enum AuthStatus { loading, authed, unauth }

extension CoursepageStatusX on AuthStatus {
  bool get isLoading => this == AuthStatus.loading;
  bool get isAuthed => this == AuthStatus.authed;
  bool get isUnauth => this == AuthStatus.unauth;
}

@JsonSerializable()
class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.eeclassUserData = User.empty,
    this.eeclassAuthenticated = AuthStatus.unauth,
    this.courseSelectUserData = User.empty,
    this.courseSelectAuthenticated = AuthStatus.unauth,
  });

  final User eeclassUserData;
  final AuthStatus eeclassAuthenticated;
  final User courseSelectUserData;
  final AuthStatus courseSelectAuthenticated;

  factory AuthenticationState.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationStateToJson(this);

  AuthenticationState copyWith({
    User? eeclassUserData,
    AuthStatus? eeclassAuthenticated,
    User? courseSelectUserData,
    AuthStatus? courseSelectAuthenticated,
  }) {
    return AuthenticationState(
        eeclassUserData: eeclassUserData ?? this.eeclassUserData,
        eeclassAuthenticated: eeclassAuthenticated ?? this.eeclassAuthenticated,
        courseSelectUserData: courseSelectUserData ?? this.courseSelectUserData,
        courseSelectAuthenticated:
            courseSelectAuthenticated ?? this.courseSelectAuthenticated);
  }

  @override
  List<Object> get props => [
        eeclassUserData,
        eeclassAuthenticated,
        courseSelectUserData,
        courseSelectAuthenticated,
      ];
}
