part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.eeclassUserData = User.empty,
    this.eeclassAuthenticated = false,
    this.courseSelectUserData = User.empty,
    this.courseSelectAuthenticated = false,
  });

  final User eeclassUserData;
  final bool eeclassAuthenticated;
  final User courseSelectUserData;
  final bool courseSelectAuthenticated;

  //  factory AuthenticationState.fromJson(Map<String, dynamic> json) =>
  //      _$AuthenticationStateFromJson(json);

  // Map<String, dynamic> toJson() => _$AuthenticationStateToJson(this);

  AuthenticationState copyWith({
    User? eeclassUserData,
    bool? eeclassAuthenticated,
    User? courseSelectUserData,
    bool? courseSelectAuthenticated,
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
