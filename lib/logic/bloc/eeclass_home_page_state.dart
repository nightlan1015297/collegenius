part of 'eeclass_home_page_bloc.dart';

abstract class EeclassHomePageState extends Equatable {
  const EeclassHomePageState();
  final List<Semester> semesterList;
  final List<EeclassCourse> courseList;

  final Semester currentSemester;
  final Semester selectedSemester;
  @override
  List<Object> get props => [];
}

class EeclassHomePageInitial extends EeclassHomePageState {}
