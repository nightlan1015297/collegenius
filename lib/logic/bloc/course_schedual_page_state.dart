part of 'course_schedual_page_bloc.dart';

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

enum DailySchedualPageRenderStatus {
  noData,
  noCourse,
  normal,
  animated,
}

class CourseSchedualPageState extends Equatable {
  CourseSchedualPageState({
    bool? renderDaily,
    bool? fetchFromLocal,
    int? currentSection,
    int? currentDays,
    String? currentSemester,
    int? selectedDays,
    String? selectedSemester,
    List<Semester>? semesterList,
    this.status = CourseSchedualPageStatus.initial,
    CourseSchedual? schedual,
    int? firstClassSection,
    int? lastClassSection,
    this.renderStatus = DailySchedualPageRenderStatus.noData,
  })  : renderDaily = renderDaily ?? false,
        schedual = schedual,
        firstClassSection = firstClassSection ?? 0,
        lastClassSection = lastClassSection ?? 0,
        fetchFromLocal = fetchFromLocal ?? false,
        semesterList = semesterList ?? <Semester>[],
        currentSection = currentSection ?? 0,
        currentSemester = currentSemester ?? '1112',
        currentDays = DateTime.now().weekday - 1,
        selectedDays = selectedDays ?? DateTime.now().weekday - 1,
        selectedSemester = selectedSemester ?? '1112';

  final bool renderDaily;
  final bool fetchFromLocal;
  final CourseSchedualPageStatus status;
  final DailySchedualPageRenderStatus renderStatus;
  final CourseSchedual? schedual;
  final int firstClassSection;
  final int lastClassSection;

  final List<Semester> semesterList;
  final int currentSection;
  final int currentDays;
  final String currentSemester;
  final int selectedDays;
  final String selectedSemester;

  CourseSchedualPageState copyWith({
    bool? renderDaily,
    bool? fetchFromLocal,
    int? currentSection,
    int? currentDays,
    String? currentSemester,
    int? selectedDays,
    String? selectedSemester,
    List<Semester>? semesterList,
    CourseSchedualPageStatus? status,
    DailySchedualPageRenderStatus? renderStatus,
    CourseSchedual? schedual,
    int? firstClassSection,
    int? lastClassSection,
  }) {
    return CourseSchedualPageState(
        renderDaily: renderDaily ?? this.renderDaily,
        status: status ?? this.status,
        fetchFromLocal: fetchFromLocal ?? this.fetchFromLocal,
        currentSection: currentSection ?? this.currentSection,
        currentDays: currentDays ?? this.currentDays,
        currentSemester: currentSemester ?? this.currentSemester,
        selectedDays: selectedDays ?? this.selectedDays,
        selectedSemester: selectedSemester ?? this.selectedSemester,
        semesterList: semesterList ?? this.semesterList,
        schedual: schedual ?? this.schedual,
        renderStatus: renderStatus ?? this.renderStatus,
        firstClassSection: firstClassSection ?? this.firstClassSection,
        lastClassSection: lastClassSection ?? this.lastClassSection);
  }

  CourseSchedualPageState copyWithNullableSchedual({
    bool? renderDaily,
    bool? fetchFromLocal,
    int? currentSection,
    int? currentDays,
    String? currentSemester,
    int? selectedDays,
    String? selectedSemester,
    List<Semester>? semesterList,
    CourseSchedualPageStatus? status,
    DailySchedualPageRenderStatus? renderStatus,
    int? firstClassSection,
    int? lastClassSection,
    required CourseSchedual? schedual,
  }) {
    return CourseSchedualPageState(
        renderDaily: renderDaily ?? this.renderDaily,
        status: status ?? this.status,
        fetchFromLocal: fetchFromLocal ?? this.fetchFromLocal,
        currentSection: currentSection ?? this.currentSection,
        currentDays: currentDays ?? this.currentDays,
        currentSemester: currentSemester ?? this.currentSemester,
        selectedDays: selectedDays ?? this.selectedDays,
        selectedSemester: selectedSemester ?? this.selectedSemester,
        semesterList: semesterList ?? this.semesterList,
        renderStatus: renderStatus ?? this.renderStatus,
        firstClassSection: firstClassSection ?? this.firstClassSection,
        lastClassSection: lastClassSection ?? this.lastClassSection,
        schedual: schedual);
  }

  @override
  List<Object?> get props => [
        status,
        renderStatus,
        renderDaily,
        fetchFromLocal,
        currentSection,
        currentDays,
        currentSemester,
        selectedDays,
        selectedSemester,
        semesterList,
        schedual,
        firstClassSection,
        lastClassSection,
      ];
}
