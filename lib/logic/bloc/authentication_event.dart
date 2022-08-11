part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class InitializeRequested extends AuthenticationEvent {
  InitializeRequested();
}

class EeclassAuthenticatedRequested extends AuthenticationEvent {
  EeclassAuthenticatedRequested({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class CourseSelectAuthenticatedRequested extends AuthenticationEvent {
  CourseSelectAuthenticatedRequested({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
