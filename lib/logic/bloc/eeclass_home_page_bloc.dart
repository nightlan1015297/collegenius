import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collegenius/models/eeclass_model/EeclassCourseBrief.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:collegenius/models/semester_model/semester_model.dart';
import 'authentication_bloc.dart';

part 'eeclass_home_page_event.dart';
part 'eeclass_home_page_state.dart';

class EeclassHomePageBloc
    extends Bloc<EeclassHomePageEvent, EeclassHomePageState> {
  EeclassHomePageBloc(
      {required this.authenticateBloc, required this.eeclassRepository})
      : super(EeclassHomePageState(status: EeclassHomePageStatus.initial)) {
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
    add(InitializeRequest());
  }

  Future<void> _onChangeSemesterRequest(
    ChangeSemesterRequest event,
    Emitter<EeclassHomePageState> emit,
  ) async {
    emit(state.copyWith(
      status: EeclassHomePageStatus.loading,
    ));
    final courseList =
        await eeclassRepository.getCourses(semester: event.semester.value);

    emit(state.copyWith(
        status: EeclassHomePageStatus.success,
        selectedSemester: event.semester,
        courseList: courseList));
  }

  void _onInitializeRequest(
    InitializeRequest event,
    Emitter<EeclassHomePageState> emit,
  ) {
    switch (authenticateBloc.state.eeclassAuthenticated.isAuthed) {
      case true:
        add(FetchDataRequest());
        break;
      case false:
        emit(EeclassHomePageState(
            status: EeclassHomePageStatus.unAuthentucated));
        break;
    }
  }

  Future<void> _onFetchDataRequest(
    FetchDataRequest event,
    Emitter<EeclassHomePageState> emit,
  ) async {
    emit(EeclassHomePageState(status: EeclassHomePageStatus.loading));

    final semesterList = await eeclassRepository.getAvaliableSemester();
    final defaultSemester = semesterList[0];
    final defaultCourseList =
        await eeclassRepository.getCourses(semester: defaultSemester.value);
    emit(EeclassHomePageState(
        status: EeclassHomePageStatus.success,
        currentSemester: defaultSemester,
        selectedSemester: defaultSemester,
        semesterList: semesterList,
        courseList: defaultCourseList));
  }

  @override
  Future<void> close() async {
    authenticateBlocSubscription.cancel();
    return await super.close();
  }

  @override
  void onChange(Change<EeclassHomePageState> change) {
    super.onChange(change);
  }
}
