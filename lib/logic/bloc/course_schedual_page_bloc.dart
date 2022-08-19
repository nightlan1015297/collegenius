import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/models/semester_model/semester_model.dart';
import 'package:collegenius/repositories/course_schedual_repository.dart';
import 'package:collegenius/utilties/ticker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import '../../models/course_schedual_model/course_schedual_models.dart';
import 'authentication_bloc.dart';

part 'course_schedual_page_event.dart';
part 'course_schedual_page_state.dart';

class CourseSchedualPageBloc
    extends Bloc<CourseSchedualPageEvent, CourseSchedualPageState> {
  CourseSchedualPageBloc({
    required this.courseSchedualRepository,
    required this.ticker,
    required this.authenticateBloc,
  }) : super(CourseSchedualPageState()) {
    _tickerSubscription = ticker.tick(5).listen((event) {
      add(UpdateTimeRequest());
    });
    _authenticateBlocSubscription = authenticateBloc.stream.listen((event) {
      add(AuthenticateStateChangedRequest(event));
    });
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((event) => add(ConnectivityStateChangedRequest(event)));
    on<InitializeRequest>(_onInitializeRequest);
    on<UpdateTimeRequest>(_onUpdateTimeRequest);
    on<AuthenticateStateChangedRequest>(_onAuthenticateStateChangedRequest);
    on<ConnectivityStateChangedRequest>(_onConnectivityStateChangedRequest);
    on<FetchDataRequest>(_onFetchDataRequest);
    on<ChangeSelectedDaysRequest>(_onChangeSelectedDaysRequest);
    on<ChangeSelectedSemesterRequest>(_onChangeSelectedSemesterRequest);
    on<UpdateRenderInfoRequest>(_onUpdateRenderInfoRequest);
  }
  final CourseSchedualRepository courseSchedualRepository;
  final Ticker ticker;
  final AuthenticationBloc authenticateBloc;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<int> _tickerSubscription;
  late StreamSubscription _authenticateBlocSubscription;
  late StreamSubscription _connectivitySubscription;

  void _onInitializeRequest(
    InitializeRequest event,
    Emitter<CourseSchedualPageState> emit,
  ) async {
    add(ConnectivityStateChangedRequest(
        await _connectivity.checkConnectivity()));
    add(AuthenticateStateChangedRequest(authenticateBloc.state));
  }

  ///updateSectionByDateTime will be called by the ticker every sec to update the current section
  void _onUpdateTimeRequest(
    UpdateTimeRequest event,
    Emitter<CourseSchedualPageState> emit,
  ) {
    var _time = DateTime.now();
    if (_time.isBefore(DateTime(_time.year, _time.month, _time.day, 8))) {
      emit(state.copyWith(currentSection: -1));
    } else if (_time
        .isAfter(DateTime(_time.year, _time.month, _time.day, 21, 50))) {
      emit(state.copyWith(currentSection: 14));
    }
    for (var i = 8; i < 21; i++) {
      if (_time.isAfter(DateTime(_time.year, _time.month, _time.day, i)) &&
          _time.isBefore(DateTime(_time.year, _time.month, _time.day, i, 50))) {
        emit(state.copyWith(currentSection: i - 7));
        break;
      }
    }
    emit(state.copyWith(currentDays: DateTime.now().weekday - 1));
  }

  Future<void> _onAuthenticateStateChangedRequest(
    AuthenticateStateChangedRequest event,
    Emitter<CourseSchedualPageState> emit,
  ) async {
    switch (event.state.courseSelectAuthStatus.isAuthed) {
      case true:
        add(FetchDataRequest());
        break;
      case false:
        emit(CourseSchedualPageState(
            status: CourseSchedualPageStatus.unauthenticated));
        break;
    }
  }

  void _onConnectivityStateChangedRequest(
    ConnectivityStateChangedRequest event,
    Emitter<CourseSchedualPageState> emit,
  ) async {
    switch (event.state) {
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
        emit(state.copyWith(fetchFromLocal: false));
        break;
      case ConnectivityResult.none:
        emit(state.copyWith(fetchFromLocal: true));
        break;
    }
  }

  Future<void> _onFetchDataRequest(
    FetchDataRequest event,
    Emitter<CourseSchedualPageState> emit,
  ) async {
    emit(state.copyWith(status: CourseSchedualPageStatus.loading));
    try {
      final result = await courseSchedualRepository.getSemesterList(
          fromLocal: state.fetchFromLocal);
      final currentSemester =
          await courseSchedualRepository.getCurrentSemester();
      emit(state.copyWith(
        currentSemester: currentSemester,
        selectedSemester: currentSemester,
      ));
      final selectedCourseSchedual =
          await courseSchedualRepository.getCourseSchedual(
              semester: state.selectedSemester,
              fromLocal: state.fetchFromLocal);
      emit(state.copyWith(
        semesterList: result,
        schedual: selectedCourseSchedual,
      ));
      add(UpdateRenderInfoRequest());
      emit(state.copyWith(status: CourseSchedualPageStatus.success));
    } catch (e, stack) {
      print(e);
      print(stack);
      emit(state.copyWith(status: CourseSchedualPageStatus.failure));
    }
  }

  void _onChangeSelectedDaysRequest(
    ChangeSelectedDaysRequest event,
    Emitter<CourseSchedualPageState> emit,
  ) {
    add(UpdateRenderInfoRequest());
    emit(state.copyWith(selectedDays: event.days));
  }

  void _onChangeSelectedSemesterRequest(
    ChangeSelectedSemesterRequest event,
    Emitter<CourseSchedualPageState> emit,
  ) async {
    emit(state.copyWith(
        selectedSemester: event.semester,
        status: CourseSchedualPageStatus.loading));
    try {
      final schedual = await courseSchedualRepository.getCourseSchedual(
        semester: event.semester,
        fromLocal: state.fetchFromLocal,
      );
      emit(state.copyWithNullableSchedual(
          schedual: schedual, selectedSemester: event.semester));
      add(UpdateRenderInfoRequest());
      emit(state.copyWith(status: CourseSchedualPageStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: CourseSchedualPageStatus.failure,
      ));
    }
  }

  void _onUpdateRenderInfoRequest(
    UpdateRenderInfoRequest event,
    Emitter<CourseSchedualPageState> emit,
  ) {
    if (state.schedual == null || state.semesterList.isEmpty) {
      emit(state.copyWith(renderStatus: CourseSchedualPageRenderStatus.noData));
      return;
    } else {
      add(UpdateTimeRequest());
      final selectedDays = mapIndexToWeekday[state.selectedDays];
      final jsonSchedual = state.schedual!.toJson();
      var firstClass = 0;
      var lastClass = 0;
      var isFirst = false;
      for (int i = 0; i < 16; i++) {
        if (jsonSchedual[selectedDays][mapIndexToSection[i]] != null) {
          if (!isFirst) {
            firstClass = i;
            isFirst = !isFirst;
          }
          lastClass = i;
        }
      }
      if (firstClass == lastClass && firstClass == 0) {
        emit(state.copyWith(
            renderStatus: CourseSchedualPageRenderStatus.noCourse));
        return;
      }
      if (state.selectedDays == state.currentDays &&
          state.selectedSemester == state.currentSemester) {
        emit(state.copyWith(
          renderStatus: CourseSchedualPageRenderStatus.animated,
          firstClassSection: firstClass,
          lastClassSection: lastClass,
        ));
        return;
      } else {
        emit(state.copyWith(
          renderStatus: CourseSchedualPageRenderStatus.normal,
          firstClassSection: firstClass,
          lastClassSection: lastClass,
        ));
      }
    }
  }

  @override
  Future<void> close() {
    _authenticateBlocSubscription.cancel();
    _tickerSubscription.cancel();
    _connectivitySubscription.cancel();
    return super.close();
  }
}
