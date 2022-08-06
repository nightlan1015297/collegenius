import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:equatable/equatable.dart';

import 'authentication_bloc.dart';

part 'eeclass_course_page_event.dart';
part 'eeclass_course_page_state.dart';

class EeclassCoursePageBloc
    extends Bloc<EeclassCoursePageEvent, EeclassCoursePageState> {
  EeclassCoursePageBloc(
      {required this.courseSerial,
      required this.authenticateBloc,
      required this.eeclassRepository})
      : super(EeclassCoursePageState()) {
    on<InitializeRequest>(_onInitializeRequest);
    on<FetchDataRequest>(_onFetchDataRequest);
    authenticateBlocSubscription = authenticateBloc.stream.listen((event) {
      onAuthenticateStatechanged(event);
    });
  }
  final EeclassRepository eeclassRepository;
  final AuthenticationBloc authenticateBloc;
  final String courseSerial;
  late StreamSubscription authenticateBlocSubscription;

  void onAuthenticateStatechanged(AuthenticationState event) {
    add(InitializeRequest());
  }

  void _onInitializeRequest(
    InitializeRequest event,
    Emitter<EeclassCoursePageState> emit,
  ) {
    switch (authenticateBloc.state.eeclassAuthenticated) {
      case true:
        add(FetchDataRequest());
        break;
      case false:
        emit(EeclassCoursePageState(
            status: EeclassCoursePageStatus.unAuthentucated));
        break;
    }
  }

  Future<void> _onFetchDataRequest(
    FetchDataRequest event,
    Emitter<EeclassCoursePageState> emit,
  ) async {
    emit(EeclassCoursePageState(
        status: EeclassCoursePageStatus.loading,
        quizInfoStatus: EeclassQuizInfoStatus.loading));
    final user = authenticateBloc.state.eeclassUserData;

    await eeclassRepository.login(username_: user.id, password_: user.password);

    final courseInformation = await eeclassRepository.getCourseInformation(
        courseSerial: this.courseSerial);
    final courseBulletin = await eeclassRepository.getCourseBulletin(
        courseSerial: this.courseSerial, page: state.bullitinFetchedPage);
    final courseAssignment = await eeclassRepository.getCourseAssignment(
        courseSerial: this.courseSerial);
    final courseMaterial = await eeclassRepository.getCourseMaterial(
        courseSerial: this.courseSerial);
    final courseQuiz =
        await eeclassRepository.getCourseQuiz(courseSerial: this.courseSerial);

    emit(state.copyWith(
        status: EeclassCoursePageStatus.success,
        courseInformation: courseInformation,
        bullitinList: courseBulletin,
        assignmentList: courseAssignment,
        materialList: courseMaterial,
        quizList: courseQuiz));
    if (courseQuiz.isNotEmpty) {
      final firstQuizInfo =
          await eeclassRepository.getQuiz(url: courseQuiz.last.url);
      final fullmarks = firstQuizInfo.fullMarks;
      final score = firstQuizInfo.score;
      if (fullmarks == null || score == null) {
        emit(state.copyWith(
          firstQuizName: firstQuizInfo.quizTitle,
          quizInfoStatus: EeclassQuizInfoStatus.canNotParse,
        ));
      } else {
        emit(state.copyWith(
            firstQuizFullmarks: fullmarks,
            firstQuizscore: score,
            firstQuizName: firstQuizInfo.quizTitle));
        final percentage = score / fullmarks;
        if (percentage > 0.7) {
          emit(state.copyWith(
            quizInfoStatus: EeclassQuizInfoStatus.good,
          ));
        } else if (percentage > 0.6 && percentage < 0.7) {
          emit(state.copyWith(
            quizInfoStatus: EeclassQuizInfoStatus.normal,
          ));
        } else {
          emit(state.copyWith(
            quizInfoStatus: EeclassQuizInfoStatus.bad,
          ));
        }
      }
    } else {
      emit(state.copyWith(
        quizInfoStatus: EeclassQuizInfoStatus.noQuiz,
      ));
    }
  }

  @override
  Future<void> close() async {
    authenticateBlocSubscription.cancel();
    await super.close();
  }
}