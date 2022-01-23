part of 'course_section_cubit.dart';

enum CourseSectionStatus { loading, success }

extension CoursepageStatusX on CourseSectionStatus {
  bool get isLoading => this == CourseSectionStatus.loading;
  bool get isSuccess => this == CourseSectionStatus.success;
}

class CourseSectionState extends Equatable {
  CourseSectionState({
    int? cerrentSection,
    int? currentDays,
    String? currentSemester,
    int? choosenDays,
    String? choosenSemester,
    this.status = CourseSectionStatus.loading,
  })  : cerrentSection = cerrentSection ?? 0,
        currentSemester = currentSemester ?? '1101',
        currentDays = DateTime.now().weekday,
        choosenDays = choosenDays ?? DateTime.now().weekday - 1,
        choosenSemester = choosenSemester ?? '1101';

  final CourseSectionStatus status;
  final int cerrentSection;
  final int currentDays;
  final String currentSemester;
  final int choosenDays;
  final String choosenSemester;

  CourseSectionState copywith({
    CourseSectionStatus? status = CourseSectionStatus.loading,
    int? cerrentSection,
    int? todayDays,
    String? currentSemester,
    int? choosenDays,
    String? choosenSemester,
  }) {
    return CourseSectionState(
        status: status ?? this.status,
        cerrentSection: cerrentSection ?? this.cerrentSection,
        currentDays: todayDays ?? this.currentDays,
        currentSemester: currentSemester ?? this.currentSemester,
        choosenDays: choosenDays ?? this.choosenDays,
        choosenSemester: choosenSemester ?? this.choosenSemester);
  }

  @override
  List<Object> get props => [
        status,
        cerrentSection,
        currentDays,
        currentSemester,
        choosenDays,
        choosenSemester
      ];
}
