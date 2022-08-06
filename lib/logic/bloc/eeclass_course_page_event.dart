part of 'eeclass_course_page_bloc.dart';

abstract class EeclassCoursePageEvent extends Equatable {
  const EeclassCoursePageEvent();

  @override
  List<Object> get props => [];
}

class InitializeRequest extends EeclassCoursePageEvent {}

class FetchDataRequest extends EeclassCoursePageEvent {}
