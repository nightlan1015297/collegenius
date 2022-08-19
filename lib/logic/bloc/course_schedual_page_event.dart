part of 'course_schedual_page_bloc.dart';

abstract class CourseSchedualPageEvent extends Equatable {
  const CourseSchedualPageEvent();

  @override
  List<Object> get props => [];
}

class InitializeRequest extends CourseSchedualPageEvent {
  InitializeRequest();
}

class FetchDataRequest extends CourseSchedualPageEvent {
  FetchDataRequest();
}

class ChangeSelectedDaysRequest extends CourseSchedualPageEvent {
  ChangeSelectedDaysRequest({required this.days});
  final int days;
  @override
  List<Object> get props => [days];
}

class ChangeSelectedSemesterRequest extends CourseSchedualPageEvent {
  ChangeSelectedSemesterRequest({required this.semester});
  final String semester;
  @override
  List<Object> get props => [semester];
}

class ConnectivityStateChangedRequest extends CourseSchedualPageEvent {
  ConnectivityStateChangedRequest(this.state);
  final ConnectivityResult state;
  @override
  List<Object> get props => [state];
}

class AuthenticateStateChangedRequest extends CourseSchedualPageEvent {
  AuthenticateStateChangedRequest(this.state);
  final AuthenticationState state;
  @override
  List<Object> get props => [state];
}

class UpdateTimeRequest extends CourseSchedualPageEvent {
  UpdateTimeRequest();
  @override
  List<Object> get props => [];
}

class UpdateRenderInfoRequest extends CourseSchedualPageEvent {}
