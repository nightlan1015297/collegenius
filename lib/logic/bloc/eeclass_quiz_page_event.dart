part of 'eeclass_quiz_page_bloc.dart';

abstract class EeclassQuizPageEvent extends Equatable {
  const EeclassQuizPageEvent();

  @override
  List<Object> get props => [];
}

/// [InitializeRequest] should be the first event when the [EeclassQuizPageBloc]
/// first create. This event will tell the [EeclassQuizPageBloc] to initialize,
/// get the data ready to render [EeclassQuizPage].

class InitializeRequest extends EeclassQuizPageEvent {}

/// [FetchOverViewDataRequest] will fetch all history quiz data (Brief)
/// Makes [EeclassQuizPage] can show all quiz in a ListView
/// The reason why just fetch quiz data in brief is to minimalize unnecessary
/// [EeclassApiClient] call.

class FetchOverViewDataRequest extends EeclassQuizPageEvent {}

class FetchQuizDataRequest extends EeclassQuizPageEvent {}
