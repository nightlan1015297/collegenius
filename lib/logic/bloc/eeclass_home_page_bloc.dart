import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/models/eeclass_model/EeclassCourseBrief.dart';
import 'package:collegenius/models/error_model/ErrorModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import 'package:collegenius/models/semester_model/semester_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'authentication_bloc.dart';

part 'eeclass_home_page_event.dart';
part 'eeclass_home_page_state.dart';

class EeclassCourseListBloc
    extends Bloc<EeclassCourseListEvent, EeclassCourseListState> {
  EeclassCourseListBloc(
      {required this.authenticateBloc, required this.eeclassRepository})
      : super(
          EeclassCourseListState(status: EeclassCourseListStatus.initial),
        ) {
    on<FetchDataRequest>(_onFetchDataRequest);
    on<InitializeRequest>(_onInitializeRequest);
    on<ChangeSemesterRequest>(_onChangeSemesterRequest);
    authenticateBlocSubscription = authenticateBloc.stream.listen((event) {
      onAuthenticateStatechanged(event);
    });
  }
  final EeclassRepository eeclassRepository;
  final AuthenticationBloc authenticateBloc;
  late StreamSubscription authenticateBlocSubscription;

  void onAuthenticateStatechanged(AuthenticationState event) {
    add(
      InitializeRequest(),
    );
  }

  Future<void> _onChangeSemesterRequest(
    ChangeSemesterRequest event,
    Emitter<EeclassCourseListState> emit,
  ) async {
    if (event.semester != state.selectedSemester) {
      emit(
        state.copyWith(
          status: EeclassCourseListStatus.loading,
        ),
      );
      final courseList =
          await eeclassRepository.getCourses(semester: event.semester.value);
      emit(
        state.copyWith(
            status: EeclassCourseListStatus.success,
            selectedSemester: event.semester,
            courseList: courseList),
      );
    }
  }

  void _onInitializeRequest(
    InitializeRequest event,
    Emitter<EeclassCourseListState> emit,
  ) {
    switch (authenticateBloc.state.eeclassAuthStatus.isAuthed) {
      case true:
        add(
          FetchDataRequest(),
        );
        break;
      case false:
        emit(
          EeclassCourseListState(
              status: EeclassCourseListStatus.unAuthentucated),
        );
        break;
    }
  }

  Future<void> _onFetchDataRequest(
    FetchDataRequest event,
    Emitter<EeclassCourseListState> emit,
  ) async {
    emit(
      EeclassCourseListState(status: EeclassCourseListStatus.loading),
    );

    try {
      final semesterList = await eeclassRepository.getAvaliableSemester();
      final defaultSemester = semesterList[1];
      final defaultCourseList =
          await eeclassRepository.getCourses(semester: defaultSemester.value);
      emit(
        EeclassCourseListState(
            status: EeclassCourseListStatus.success,
            currentSemester: defaultSemester,
            selectedSemester: defaultSemester,
            semesterList: semesterList,
            courseList: defaultCourseList),
      );
    } catch (e, stacktrace) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      final _crashInstance = FirebaseCrashlytics.instance;
      _crashInstance.setCustomKey("Error on", "Eeclass_courses_list");
      _crashInstance.setCustomKey("Catch on", "Fetching data");
      _crashInstance.setCustomKey("Connection type", connectivityResult.name);
      _crashInstance.recordError(e, stacktrace);
      emit(
        EeclassCourseListState(
            error: ErrorModel(
                exception: e.toString(), stackTrace: stacktrace.toString()),
            status: EeclassCourseListStatus.failed),
      );
    }
  }

  @override
  Future<void> close() async {
    authenticateBlocSubscription.cancel();
    return await super.close();
  }

  @override
  void onChange(Change<EeclassCourseListState> change) {
    super.onChange(change);
  }
}
