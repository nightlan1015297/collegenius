part of 'course_schedual_cubit.dart';

enum CourseSchedualStatus { initial, loading, success, failure }

extension CoursepageStatusX on CourseSchedualStatus {
  bool get isInitial => this == CourseSchedualStatus.initial;
  bool get isLoading => this == CourseSchedualStatus.loading;
  bool get isSuccess => this == CourseSchedualStatus.success;
  bool get isFailure => this == CourseSchedualStatus.failure;
}

@JsonSerializable()
class CourseSchedualState extends Equatable {
  final CourseSchedualStatus status;
  final CourseSchedual schedual;

  CourseSchedualState({
    this.status = CourseSchedualStatus.initial,
    CourseSchedual? schedual,
  }) : schedual = schedual ?? CourseSchedual.empty;

  factory CourseSchedualState.fromJson(Map<String, dynamic> json) =>
      _$CourseSchedualStateFromJson(json);

  CourseSchedualState copywith(
      {CourseSchedualStatus? status, CourseSchedual? schedual}) {
    return CourseSchedualState(
        status: status ?? this.status, schedual: schedual ?? this.schedual);
  }

  Map<String, dynamic> toJson() => _$CourseSchedualStateToJson(this);
  @override
  List<Object> get props => [status, schedual];
}
