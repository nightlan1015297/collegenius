import 'package:bloc/bloc.dart';
import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/models/user_model/user_model.dart';
import 'package:collegenius/repositories/authtication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc(
      {required AuthenticationRepository authenticationRepository,
      required AuthenticationBloc authenticationBloc})
      : authenticationRepository = authenticationRepository,
        authenticationBloc = authenticationBloc,
        super(const LoginPageState()) {
    on<LoginStudentIdChanged>(_onStudentIdChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LogoutRequst>(_onLogoutRequest);
  }

  AuthenticationRepository authenticationRepository;
  final AuthenticationBloc authenticationBloc;
  void _onStudentIdChanged(
    LoginStudentIdChanged event,
    Emitter<LoginPageState> emit,
  ) {
    final studentId = StudentId.dirty(event.studentId);
    emit(state.copyWith(
      studentId: studentId,
      status: Formz.validate([state.password, studentId]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginPageState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.studentId]),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginPageState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        var authResult = await authenticationRepository.authFromMultipleServer(
          id: state.studentId.value,
          password: state.password.value,
        );
        if (authResult[Server.eeclass]!) {
          authenticationBloc.add(EeclassAuthenticatedRequested(
              user: User(
                  id: state.studentId.value, password: state.password.value)));
        }
        if (authResult[Server.courseSelect]!) {
          authenticationBloc.add(CourseSelectAuthenticatedRequested(
              user: User(
                  id: state.studentId.value, password: state.password.value)));
        }
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  void _onLogoutRequest(
    LogoutRequst event,
    Emitter<LoginPageState> emit,
  ) {
    this.authenticationRepository = AuthenticationRepository();
    emit(LoginPageState());
  }
}
