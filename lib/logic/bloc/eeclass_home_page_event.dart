part of 'eeclass_home_page_bloc.dart';

abstract class EeclassCourseListEvent extends Equatable {
  const EeclassCourseListEvent();

  @override
  List<Object> get props => [];
}

class InitializeRequest extends EeclassCourseListEvent {}

class FetchDataRequest extends EeclassCourseListEvent {}

class ChangeSemesterRequest extends EeclassCourseListEvent {
  final Semester semester;

  ChangeSemesterRequest({required this.semester});

  @override
  List<Object> get props => [semester];
}
