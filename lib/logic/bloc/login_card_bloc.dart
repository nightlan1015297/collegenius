
import 'package:bloc/bloc.dart';
import 'package:collegenius/models/user_model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../constants/enums.dart';

part 'login_card_event.dart';
part 'login_card_state.dart';

class LoginCardBloc extends Bloc<LoginCardEvent, LoginCardState> {
  LoginCardBloc() : super(const LoginCardState()) {
    on<LoginStudentIdChanged>(_onStudentIdChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
  }

  void _onStudentIdChanged(
    LoginStudentIdChanged event,
    Emitter<LoginCardState> emit,
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
    Emitter<LoginCardState> emit,
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
}
