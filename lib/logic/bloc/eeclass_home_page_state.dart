part of 'eeclass_home_page_bloc.dart';

enum EeclassHomePageStatus {
  unAuthentucated,
  initial,
  loading,
  success,
  failed,
}

class EeclassHomePageState extends Equatable {
  EeclassHomePageState({
    EeclassHomePageStatus? status,
    List<Semester>? semesterList,
    List<EeclassCourseBrief>? courseList,
    Semester? currentSemester,
    Semester? selectedSemester,
  })  : status = status ?? EeclassHomePageStatus.initial,
        semesterList = semesterList ?? [],
        courseList = courseList ?? [],
        currentSemester = currentSemester,
        selectedSemester = selectedSemester;

  final EeclassHomePageStatus status;
  final List<Semester> semesterList;
  final List<EeclassCourseBrief> courseList;

  final Semester? currentSemester;
  final Semester? selectedSemester;

  EeclassHomePageState copyWith(
      {EeclassHomePageStatus? status,
      List<Semester>? semesterList,
      List<EeclassCourseBrief>? courseList,
      Semester? currentSemester,
      Semester? selectedSemester}) {
    return EeclassHomePageState(
        status: status ?? this.status,
        semesterList: semesterList ?? this.semesterList,
        courseList: courseList ?? this.courseList,
        currentSemester: currentSemester ?? this.currentSemester,
        selectedSemester: selectedSemester ?? this.selectedSemester);
  }

  // EeclassHomePageState copyWithNullableCourseList(
  //     {EeclassHomePageStatus? status,
  //     List<Semester>? semesterList,
  //     required List<EeclassCourseBrief>? courseList,
  //     Semester? currentSemester,
  //     Semester? selectedSemester}) {
  //   return EeclassHomePageState(
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
      ];
}
