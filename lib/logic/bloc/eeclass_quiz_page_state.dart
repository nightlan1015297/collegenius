part of 'eeclass_quiz_page_bloc.dart';

enum EeclassQuizPageOverviewStatus {
  initial,
  unauthenticate,
  loading,
  noquiz,
  success,
  failed
}

enum EeclassQuizPageStatus {
  loading,
  success,
  failed,
  unauthenticate,
}

class EeclassQuizPageState extends Equatable {
  EeclassQuizPageState(
      {List<EeclassQuizBrief>? quizList,
      EeclassQuizPageOverviewStatus? overviewStatus})
      : quizList = quizList ?? [],
        overviewStatus =
            overviewStatus ?? EeclassQuizPageOverviewStatus.initial;

  final List<EeclassQuizBrief> quizList;
  final EeclassQuizPageOverviewStatus overviewStatus;

  EeclassQuizPageState copyWith(
      {List<EeclassQuizBrief>? quizList,
      EeclassQuizPageOverviewStatus? overviewStatus}) {
    return EeclassQuizPageState(
      overviewStatus: overviewStatus ?? this.overviewStatus,
      quizList: quizList ?? this.quizList,
    );
  }

  @override
  List<Object> get props => [quizList, overviewStatus];
}
