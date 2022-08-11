part of 'eeclass_quiz_detail_cubit.dart';

enum EeclassQuizDetailCardStatus {
  loading,
  success,
  failed,
  unauthenticate,
}

class EeclassQuizDetailState extends Equatable {
  const EeclassQuizDetailState({
    EeclassQuizDetailCardStatus? quizCardStatus,
    EeclassQuiz? quizCardData,
  })  : quizCardStatus = quizCardStatus ?? EeclassQuizDetailCardStatus.loading,
        quizCardData = quizCardData;
  final EeclassQuizDetailCardStatus quizCardStatus;
  final EeclassQuiz? quizCardData;

  EeclassQuizDetailState copyWith({
    EeclassQuizDetailCardStatus? quizCardStatus,
    EeclassQuiz? quizCardData,
  }) {
    return EeclassQuizDetailState(
      quizCardStatus: quizCardStatus ?? this.quizCardStatus,
      quizCardData: quizCardData ?? this.quizCardData,
    );
  }

  @override
  List<Object?> get props => [
        quizCardStatus,
        quizCardData,
      ];
}
