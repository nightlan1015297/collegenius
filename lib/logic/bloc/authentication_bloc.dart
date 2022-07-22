import 'package:bloc/bloc.dart';
import 'package:collegenius/models/user_model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState.unAuthenticated()) {
    on<CourseSelectAuthenticatedRequested>(
        _onCourseSelectAuthenticatedRequested);
    on<EeclassAuthenticatedRequested>(_onEeclassAuthenticatedRequested);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
  }

  void _onCourseSelectAuthenticatedRequested(
    CourseSelectAuthenticatedRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit(AuthenticationState.courseSelectAuthenticated(event.user));
  }

  void _onEeclassAuthenticatedRequested(
    EeclassAuthenticatedRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit(AuthenticationState.eeclassAuthenticated(event.user));
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit(AuthenticationState.unAuthenticated());
  }
}
