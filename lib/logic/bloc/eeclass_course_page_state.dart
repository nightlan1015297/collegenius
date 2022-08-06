part of 'eeclass_course_page_bloc.dart';

enum EeclassCoursePageStatus {
  unAuthentucated,
  initial,
  loading,
  success,
  failed,
}

enum EeclassQuizInfoStatus {
  loading,
  good,
  normal,
  bad,
  canNotParse,
  noQuiz,
}

class EeclassCoursePageState extends Equatable {
  EeclassCoursePageState(
      {EeclassCoursePageStatus? status,
      bool? bullitinHasFechedToEnd,
      int? bullitinFetchedPage,
      List<EeclassBullitinBrief>? bullitinList,
      List<EeclassAssignmentBrief>? assignmentList,
      List<EeclassQuizBrief>? quizList,
      List<EeclassMaterialBrief>? materialList,
      EeclassCourseInformation? courseInformation,
      double? firstQuizscore,
      double? firstQuizFullmarks,
      EeclassQuizInfoStatus? quizInfoStatus,
      String? firstQuizName})
      : status = status ?? EeclassCoursePageStatus.initial,
        bullitinHasFechedToEnd = bullitinHasFechedToEnd ?? false,
        bullitinFetchedPage = bullitinFetchedPage ?? 1,
        bullitinList = bullitinList ?? [],
        assignmentList = assignmentList ?? [],
        quizList = quizList ?? [],
        materialList = materialList ?? [],
        courseInformation = courseInformation ?? EeclassCourseInformation(),
        firstQuizName = firstQuizName,
        firstQuizscore = firstQuizscore,
        firstQuizFullmarks = firstQuizFullmarks,
        quizInfoStatus = quizInfoStatus ?? EeclassQuizInfoStatus.loading;

  final bool bullitinHasFechedToEnd;

  final int bullitinFetchedPage;
  final EeclassCoursePageStatus status;
  final List<EeclassBullitinBrief> bullitinList;
  final List<EeclassAssignmentBrief> assignmentList;
  final List<EeclassQuizBrief> quizList;
  final List<EeclassMaterialBrief> materialList;

  final EeclassCourseInformation courseInformation;

  final String? firstQuizName;
  final double? firstQuizscore;
  final double? firstQuizFullmarks;
  final EeclassQuizInfoStatus quizInfoStatus;

  EeclassCoursePageState copyWith({
    EeclassCoursePageStatus? status,
    bool? bullitinHasFechedToEnd,
    int? bullitinFetchedPage,
    List<EeclassBullitinBrief>? bullitinList,
    List<EeclassAssignmentBrief>? assignmentList,
    List<EeclassQuizBrief>? quizList,
    List<EeclassMaterialBrief>? materialList,
    EeclassCourseInformation? courseInformation,
    String? firstQuizName,
    double? firstQuizscore,
    double? firstQuizFullmarks,
    EeclassQuizInfoStatus? quizInfoStatus,
  }) {
    return EeclassCoursePageState(
        status: status ?? this.status,
        bullitinHasFechedToEnd:
            bullitinHasFechedToEnd ?? this.bullitinHasFechedToEnd,
        bullitinFetchedPage: bullitinFetchedPage ?? this.bullitinFetchedPage,
        bullitinList: bullitinList ?? this.bullitinList,
        assignmentList: assignmentList ?? this.assignmentList,
        quizList: quizList ?? this.quizList,
        materialList: materialList ?? this.materialList,
        courseInformation: courseInformation ?? this.courseInformation,
        firstQuizName: firstQuizName ?? this.firstQuizName,
        firstQuizscore: firstQuizscore ?? this.firstQuizscore,
        firstQuizFullmarks: firstQuizFullmarks ?? this.firstQuizFullmarks,
        quizInfoStatus: quizInfoStatus ?? this.quizInfoStatus);
  }

  @override
  List<Object?> get props => [
        status,
        bullitinHasFechedToEnd,
        bullitinFetchedPage,
        bullitinList,
        assignmentList,
        quizList,
        materialList,
        courseInformation,
        firstQuizName,
        firstQuizscore,
        firstQuizFullmarks,
        quizInfoStatus,
      ];
}
