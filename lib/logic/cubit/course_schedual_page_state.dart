part of 'course_schedual_page_cubit.dart';

enum CourseSchedualPageStatus {
  initial,
  loading,
  success,
  failure,
  unauthenticated
}

extension CoursepageStatusX on CourseSchedualPageStatus {
  bool get isInitial => this == CourseSchedualPageStatus.initial;
  bool get isLoading => this == CourseSchedualPageStatus.loading;
  bool get isSuccess => this == CourseSchedualPageStatus.success;
  bool get isFailure => this == CourseSchedualPageStatus.failure;
  bool get isUnauthenticated =>
      this == CourseSchedualPageStatus.unauthenticated;
}

class CourseSchedualPageState extends Equatable {
  final bool fetchFromLocal;
  final CourseSchedualPageStatus status;
  final CourseSchedual? schedual;
  final List<Semester> semesterList;
  final int cerrentSection;
  final int currentDays;
  final String currentSemester;
  final int selectedDays;
  final String selectedSemester;

  CourseSchedualPageState({
    bool? fetchFromLocal,
    int? cerrentSection,
    int? currentDays,
    String? currentSemester,
    int? selectedDays,
    String? selectedSemester,
    List<Semester>? semesterList,
    this.status = CourseSchedualPageStatus.initial,
    CourseSchedual? schedual,
  })  : schedual = schedual,
        fetchFromLocal = fetchFromLocal ?? true,
        semesterList = semesterList ?? <Semester>[],
        cerrentSection = cerrentSection ?? 0,
        currentSemester = currentSemester ?? '1102',
        currentDays = DateTime.now().weekday - 1,
        selectedDays = selectedDays ?? DateTime.now().weekday - 1,
        selectedSemester = selectedSemester ?? '1102';

  CourseSchedualPageState copywith({
    bool? fetchFromLocal,
    int? cerrentSection,
    int? currentDays,
    String? currentSemester,
    int? selectedDays,
    String? selectedSemester,
    List<Semester>? semesterList,
    CourseSchedualPageStatus? status,
    CourseSchedual? schedual,
  }) {
    return CourseSchedualPageState(
        status: status ?? this.status,
        fetchFromLocal: fetchFromLocal ?? this.fetchFromLocal,
        cerrentSection: cerrentSection ?? this.cerrentSection,
        currentDays: currentDays ?? this.currentDays,
        currentSemester: currentSemester ?? this.currentSemester,
        selectedDays: selectedDays ?? this.selectedDays,
        selectedSemester: selectedSemester ?? this.selectedSemester,
        semesterList: semesterList ?? this.semesterList,
        schedual: schedual ?? this.schedual);
  }

  CourseSchedualPageState copywithNullableSchedual({
    bool? fetchFromLocal,
    int? cerrentSection,
    int? currentDays,
    String? currentSemester,
    int? selectedDays,
    String? selectedSemester,
    List<Semester>? semesterList,
    CourseSchedualPageStatus? status,
    required CourseSchedual? schedual,
  }) {
    return CourseSchedualPageState(
        status: status ?? this.status,
        fetchFromLocal: fetchFromLocal ?? this.fetchFromLocal,
        cerrentSection: cerrentSection ?? this.cerrentSection,
        currentDays: currentDays ?? this.currentDays,
        currentSemester: currentSemester ?? this.currentSemester,
        selectedDays: selectedDays ?? this.selectedDays,
        selectedSemester: selectedSemester ?? this.selectedSemester,
        semesterList: semesterList ?? this.semesterList,
        schedual: schedual);
  }

  @override
  List<Object?> get props => [
        status,
        fetchFromLocal,
        semesterList,
        schedual,
        cerrentSection,
        currentDays,
        currentSemester,
        selectedDays,
        selectedSemester
      ];
}
