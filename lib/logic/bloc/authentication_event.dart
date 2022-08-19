part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class InitializeRequest extends AuthenticationEvent {
  InitializeRequest();
}

class EeclassAuthenticateRequest extends AuthenticationEvent {
  EeclassAuthenticateRequest({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class CourseSelectAuthenticateRequest extends AuthenticationEvent {
  CourseSelectAuthenticateRequest({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class PortalAuthenticateRequest extends AuthenticationEvent {
  PortalAuthenticateRequest({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class PortalCaptchaAcquiredRequest extends AuthenticationEvent {
  final List<Cookie> cookies;
  PortalCaptchaAcquiredRequest({required this.cookies});
}

class AuthenticationLogoutRequest extends AuthenticationEvent {}
