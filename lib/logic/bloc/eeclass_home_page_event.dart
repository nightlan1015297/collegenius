part of 'eeclass_home_page_bloc.dart';

abstract class EeclassHomePageEvent extends Equatable {
  const EeclassHomePageEvent();

  @override
  List<Object> get props => [];
}

class InitializeRequest extends EeclassHomePageEvent {}

class FetchDataRequest extends EeclassHomePageEvent {}

class ChangeSemesterRequest extends EeclassHomePageEvent {
  final Semester semester;

  ChangeSemesterRequest({required this.semester});

  @override
  List<Object> get props => [semester];
}
