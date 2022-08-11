import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/models/semester_model/semester_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import 'package:collegenius/models/course_schedual_model/course_schedual_models.dart';
import 'package:collegenius/repositories/course_schedual_repository.dart';
import 'package:collegenius/utilties/ticker.dart';

part 'course_schedual_page_state.dart';

class CourseSchedualPageCubit extends Cubit<CourseSchedualPageState> {
  CourseSchedualRepository courseSchedualRepository;

  final Ticker ticker;
  final AuthenticationBloc authenticateBloc;
  late StreamSubscription<int> _tickerSubscription;
  late StreamSubscription _authenticateBlocSubscription;
  late StreamSubscription _connectivitySubscription;
  CourseSchedualPageCubit({
    required this.ticker,
    required this.courseSchedualRepository,
    required this.authenticateBloc,
  }) : super(CourseSchedualPageState()) {
    _tickerSubscription =
        ticker.tick(1).listen((_) => updateSectionByDateTime());
    _authenticateBlocSubscription = authenticateBloc.stream
        .listen((event) => mapAuthenticationEventToState(event));
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((event) => mapConnectivityEventToState(event));
  }
  void toggleCourseSection(int section) =>
      emit(state.copywith(cerrentSection: section));

  ///updateSectionByDateTime will be called by the ticker every sec to update the current section
  void updateSectionByDateTime() {
    var _time = DateTime.now();
    if (_time.isBefore(DateTime(_time.year, _time.month, _time.day, 8))) {
      toggleCourseSection(-1);
    } else if (_time
        .isAfter(DateTime(_time.year, _time.month, _time.day, 21, 50))) {
      toggleCourseSection(14);
    }
    for (var i = 8; i < 21; i++) {
      if (_time.isAfter(DateTime(_time.year, _time.month, _time.day, i)) &&
          _time.isBefore(DateTime(_time.year, _time.month, _time.day, i, 50))) {
        toggleCourseSection(i - 7);
        break;
      }
    }
  }

// Initialize the state of the page
  void initState() async {
    final isAuthed = authenticateBloc.state.courseSelectAuthenticated.isAuthed;
    if (isAuthed) {
      await fetchData();
    } else {
      emit(CourseSchedualPageState(
          status: CourseSchedualPageStatus.unauthenticated));
    }
  }
// This will be called when the page needs to be rendered and the state is initial

  Future<void> mapAuthenticationEventToState(AuthenticationState event) async {
    switch (event.courseSelectAuthenticated.isAuthed) {
      case true:
        await fetchData();
        break;
      case false:
        emit(CourseSchedualPageState(
            status: CourseSchedualPageStatus.unauthenticated));
        break;
    }
  }

  void mapConnectivityEventToState(ConnectivityResult event) {
    switch (event) {
      case ConnectivityResult.bluetooth:
        emit(state.copywith(fetchFromLocal: false));
        break;
      case ConnectivityResult.wifi:
        emit(state.copywith(fetchFromLocal: false));
        break;
      case ConnectivityResult.ethernet:
        emit(state.copywith(fetchFromLocal: false));
        break;
      case ConnectivityResult.mobile:
        emit(state.copywith(fetchFromLocal: false));
        break;
      case ConnectivityResult.none:
        emit(state.copywith(fetchFromLocal: true));
        break;
    }
  }

  Future<void> changeSemester({required String semester}) async {
    emit(state.copywith(
        selectedSemester: semester, status: CourseSchedualPageStatus.loading));
    try {
      final schedual = await courseSchedualRepository.getCourseSchedual(
        semester: semester,
        fromLocal: state.fetchFromLocal,
      );
      emit(state.copywithNullableSchedual(
          status: CourseSchedualPageStatus.success,
          schedual: schedual,
          selectedSemester: semester));
    } catch (e) {
      emit(state.copywith(
        status: CourseSchedualPageStatus.failure,
      ));
    }
  }

  void changeDays({required int days}) {
    emit(state.copywith(selectedDays: days));
  }

  Future<void> fetchData() async {
    emit(state.copywith(status: CourseSchedualPageStatus.loading));
    try {
      final result = await courseSchedualRepository.getSemesterList(
          fromLocal: state.fetchFromLocal);
      final currentSemester =
          await courseSchedualRepository.getCurrentSemester();
      emit(state.copywith(
        currentSemester: currentSemester,
        selectedSemester: currentSemester,
      ));
      final selectedCourseSchedual =
          await courseSchedualRepository.getCourseSchedual(
              semester: state.selectedSemester,
              fromLocal: state.fetchFromLocal);
      emit(state.copywith(
        status: CourseSchedualPageStatus.success,
        semesterList: result,
        schedual: selectedCourseSchedual,
      ));
    } catch (e) {
      emit(state.copywith(status: CourseSchedualPageStatus.failure));
    }
  }

  @override
  Future<void> close() {
    _authenticateBlocSubscription.cancel();
    _tickerSubscription.cancel();
    _connectivitySubscription.cancel();
    return super.close();
  }

  @override
  void onChange(Change<CourseSchedualPageState> state) {
    super.onChange(state);
  }
}
