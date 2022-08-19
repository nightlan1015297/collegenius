part of 'authentication_bloc.dart';

enum AuthStatus {
  loading,
  authed,
  unauth,
}

enum PortalAuthStatus {
  loading,
  needCaptcha,
  authed,
  unauth,
}

extension CoursepageStatusX on AuthStatus {
  bool get isLoading => this == AuthStatus.loading;
  bool get isAuthed => this == AuthStatus.authed;
  bool get isUnauth => this == AuthStatus.unauth;
}

extension PortalAuthStatusX on PortalAuthStatus {
  bool get isLoading => this == PortalAuthStatus.loading;
  bool get isAuthed => this == PortalAuthStatus.authed;
  bool get isUnauth => this == PortalAuthStatus.unauth;
  bool get isNeedCaptcha => this == PortalAuthStatus.needCaptcha;
}

@JsonSerializable()
class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.eeclassUserData = User.empty,
    this.eeclassAuthStatus = AuthStatus.unauth,
    this.eeclassError,
    this.courseSelectUserData = User.empty,
    this.courseSelectAuthStatus = AuthStatus.unauth,
    this.courseSelectError,
    this.portalUserData = User.empty,
    this.portalAuthStatus = PortalAuthStatus.unauth,
    this.portalError,
  });

  final User eeclassUserData;
  final AuthStatus eeclassAuthStatus;
  final ErrorModel? eeclassError;

  final User courseSelectUserData;
  final AuthStatus courseSelectAuthStatus;
  final ErrorModel? courseSelectError;

  final User portalUserData;
  final PortalAuthStatus portalAuthStatus;
  final ErrorModel? portalError;

  factory AuthenticationState.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationStateToJson(this);

  AuthenticationState copyWith({
    User? eeclassUserData,
    AuthStatus? eeclassAuthStatus,
    ErrorModel? eeclassError,
    User? courseSelectUserData,
    AuthStatus? courseSelectAuthStatus,
    ErrorModel? courseSelectError,
    User? portalUserData,
    PortalAuthStatus? portalAuthStatus,
    ErrorModel? portalError,
  }) {
    return AuthenticationState(
        eeclassUserData: eeclassUserData ?? this.eeclassUserData,
        eeclassAuthStatus: eeclassAuthStatus ?? this.eeclassAuthStatus,
        eeclassError: eeclassError ?? this.eeclassError,
        courseSelectUserData: courseSelectUserData ?? this.courseSelectUserData,
        courseSelectAuthStatus:
            courseSelectAuthStatus ?? this.courseSelectAuthStatus,
        courseSelectError: courseSelectError ?? this.courseSelectError,
        portalUserData: portalUserData ?? this.portalUserData,
        portalAuthStatus: portalAuthStatus ?? this.portalAuthStatus,
        portalError: portalError ?? this.portalError);
  }

  @override
  List<Object?> get props => [
        eeclassUserData,
        eeclassAuthStatus,
        eeclassError,
        courseSelectUserData,
        courseSelectAuthStatus,
        courseSelectError,
        portalUserData,
        portalAuthStatus,
        portalError,
      ];
}
