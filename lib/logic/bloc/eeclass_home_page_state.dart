part of 'eeclass_home_page_bloc.dart';

class EeclassCourseListState extends Equatable {
  EeclassCourseListState({
    EeclassCourseListStatus? status,
    List<Semester>? semesterList,
    List<EeclassCourseBrief>? courseList,
    Semester? currentSemester,
    Semester? selectedSemester,
    ErrorModel? error,
  })  : status = status ?? EeclassCourseListStatus.initial,
        semesterList = semesterList ?? [],
        courseList = courseList ?? [],
        currentSemester = currentSemester,
        selectedSemester = selectedSemester,
        error = error,
        super();
  final EeclassCourseListStatus status;
  final List<Semester> semesterList;
  final List<EeclassCourseBrief> courseList;

  final Semester? currentSemester;
  final Semester? selectedSemester;
  final ErrorModel? error;

  EeclassCourseListState copyWith({
    EeclassCourseListStatus? status,
    List<Semester>? semesterList,
    List<EeclassCourseBrief>? courseList,
    Semester? currentSemester,
    Semester? selectedSemester,
    ErrorModel? error,
  }) {
    return EeclassCourseListState(
        status: status ?? this.status,
        semesterList: semesterList ?? this.semesterList,
        courseList: courseList ?? this.courseList,
        currentSemester: currentSemester ?? this.currentSemester,
        selectedSemester: selectedSemester ?? this.selectedSemester,
        error: error ?? this.error);
  }

  // EeclassCourseListState copyWithNullableCourseList(
  //     {EeclassCourseListStatus? status,
  //     List<Semester>? semesterList,
  //     required List<EeclassCourseBrief>? courseList,
  //     Semester? currentSemester,
  //     Semester? selectedSemester}) {
  //   return EeclassCourseListState(
  //       status: status ?? this.status,
  //       semesterList: semesterList ?? this.semesterList,
  //       courseList: courseList,
  //       currentSemester: currentSemester ?? this.currentSemester,
  //       selectedSemester: selectedSemester ?? this.selectedSemester);
  // }

  @override
  List<Object?> get props => [
        status,
        semesterList,
        courseList,
        currentSemester,
        selectedSemester,
        error
      ];
}
