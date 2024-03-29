import 'dart:async';

import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/models/user_model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';
part 'login_page_bloc.g.dart';

class LoginPageBloc extends HydratedBloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc({required AuthenticationBloc authenticationBloc})
      : authenticationBloc = authenticationBloc,
        super(const LoginPageState()) {
    on<LoginStudentIdChanged>(_onStudentIdChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LogoutRequst>(_onLogoutRequest);
  }

  final AuthenticationBloc authenticationBloc;

  void _onStudentIdChanged(
    LoginStudentIdChanged event,
    Emitter<LoginPageState> emit,
  ) {
    final studentId = StudentId.dirty(event.studentId);
    if (Formz.validate([state.password, studentId])){
      emit(state.copyWith(
      studentId: studentId,
      status: VerifyStatus.valid,
    ));
    }else{emit(state.copyWith(
      studentId: studentId,
      status: VerifyStatus.invalid,
    ));}
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginPageState> emit,
  ) {
    final password = Password.dirty(event.password);
    if (Formz.validate([password, state.studentId])){
      emit(state.copyWith(
      password: password,
      status: VerifyStatus.valid,
    ));
    }else{emit(state.copyWith(
      password: password,
      status: VerifyStatus.invalid,
    ));}
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginPageState> emit,
  ) async {
    if (state.status.isValid) {
      emit(state.copyWith(progress: SubmissionProgress.success));
      print(state.studentId.value);
      print(state.password.value);
      authenticationBloc.add(CourseSelectAuthenticateRequest(
          user:
              User(id: state.studentId.value, password: state.password.value)));
      authenticationBloc.add(EeclassAuthenticateRequest(
          user:
              User(id: state.studentId.value, password: state.studentId.value)));
      //! Portal related Service
      // authenticationBloc.add(PortalAuthenticateRequest(
      //     user:
      //         User(id: state.studentId.value, password: state.password.value)));
    }
  }

  void _onLogoutRequest(
    LogoutRequst event,
    Emitter<LoginPageState> emit,
  ) {
    emit(LoginPageState());
  }

  @override
  Future<void> close() async {
    return await super.close();
  }

  @override
  LoginPageState? fromJson(Map<String, dynamic> json) {
    return LoginPageState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(LoginPageState state) {
    return state.toJson();
  }
}
