import 'package:collegenius/models/user_model/user_model.dart';
import 'package:collegenius/repositories/course_schedual_repository.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.g.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.eeclassRepository,
    required this.courseSchedualRepository,
  }) : super(const AuthenticationState()) {
    on<CourseSelectAuthenticatedRequested>(
        _onCourseSelectAuthenticatedRequested);
    on<EeclassAuthenticatedRequested>(_onEeclassAuthenticatedRequested);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<InitializeRequested>(_onInitializeRequested);
  }
  final EeclassRepository eeclassRepository;
  final CourseSchedualRepository courseSchedualRepository;

  void _onInitializeRequested(
    InitializeRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (state.courseSelectAuthenticated.isAuthed) {
      emit(state.copyWith(courseSelectAuthenticated: AuthStatus.loading));
      await courseSchedualRepository.login(
          username: state.courseSelectUserData.id,
          password: state.courseSelectUserData.password);
      emit(state.copyWith(courseSelectAuthenticated: AuthStatus.authed));
    }
    if (state.eeclassAuthenticated.isAuthed) {
      emit(state.copyWith(eeclassAuthenticated: AuthStatus.loading));
      await eeclassRepository.login(
          username_: state.eeclassUserData.id,
          password_: state.eeclassUserData.password);
      emit(state.copyWith(eeclassAuthenticated: AuthStatus.authed));
    }
  }

  void _onCourseSelectAuthenticatedRequested(
    CourseSelectAuthenticatedRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await courseSchedualRepository.login(
        username: event.user.id, password: event.user.password);
    return emit(state.copyWith(
        courseSelectAuthenticated: AuthStatus.authed,
        courseSelectUserData: event.user));
  }

  void _onEeclassAuthenticatedRequested(
    EeclassAuthenticatedRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await eeclassRepository.login(
        username_: event.user.id, password_: event.user.password);
    return emit(state.copyWith(
        eeclassAuthenticated: AuthStatus.authed, eeclassUserData: event.user));
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    eeclassRepository.logout();
    courseSchedualRepository.logout();
    return emit(AuthenticationState());
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    return AuthenticationState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return state.toJson();
  }
}
