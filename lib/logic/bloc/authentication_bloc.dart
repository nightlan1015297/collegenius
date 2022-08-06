import 'package:bloc/bloc.dart';
import 'package:collegenius/models/user_model/user_model.dart';
import 'package:collegenius/repositories/course_schedual_repository.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.eeclassRepository,
    required this.courseSchedualRepository,
  }) : super(const AuthenticationState()) {
    on<CourseSelectAuthenticatedRequested>(
        _onCourseSelectAuthenticatedRequested);
    on<EeclassAuthenticatedRequested>(_onEeclassAuthenticatedRequested);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
  }
  final EeclassRepository eeclassRepository;
  final CourseSchedualRepository courseSchedualRepository;

  void _onCourseSelectAuthenticatedRequested(
    CourseSelectAuthenticatedRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit(state.copyWith(
        courseSelectAuthenticated: true, courseSelectUserData: event.user));
  }

  void _onEeclassAuthenticatedRequested(
    EeclassAuthenticatedRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit(state.copyWith(
        eeclassAuthenticated: true, eeclassUserData: event.user));
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    eeclassRepository.logout();
    courseSchedualRepository.logout();
    return emit(AuthenticationState());
  }
}
