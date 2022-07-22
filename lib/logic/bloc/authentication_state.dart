part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.eeclassUserData = User.empty,
    this.eeclassAuthenticated = false,
    this.courseSelectUserData = User.empty,
    this.courseSelectAuthenticated = false,
  });

  final User eeclassUserData;
  final bool eeclassAuthenticated;
  final User courseSelectUserData;
  final bool courseSelectAuthenticated;
  const AuthenticationState.unAuthenticated() : this._();

  // factory AuthenticationState.fromJson(Map<String, dynamic> json) =>
  //     _$AuthenticationStateFromJson(json);

  // Map<String, dynamic> toJson() => _$AuthenticationStateToJson(this);
  const AuthenticationState.eeclassAuthenticated(User user)
      : this._(eeclassAuthenticated: true, eeclassUserData: user);

  const AuthenticationState.courseSelectAuthenticated(User user)
      : this._(courseSelectAuthenticated: true, courseSelectUserData: user);
  @override
  List<Object> get props => [
        eeclassUserData,
        eeclassAuthenticated,
        courseSelectUserData,
        courseSelectAuthenticated,
      ];
}
