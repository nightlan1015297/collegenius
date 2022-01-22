import 'package:collegenius/models/course_schedual_model/course_schedual_models.dart';
import 'package:course_schedual_repository/course_schedual_repository.dart'
    show CourseSchedualRepository;

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_schedual_cubit.g.dart';
part 'course_schedual_state.dart';

class CourseSchedualCubit extends HydratedCubit<CourseSchedualState> {
  CourseSchedualCubit(this._courseSchedualRepository)
      : super(CourseSchedualState());
  final CourseSchedualRepository _courseSchedualRepository;

  Future<void> fetchCourseSchedual(String semester) async {
    emit(state.copywith(status: CourseSchedualStatus.loading));
    try {
      final courseSchedual = CourseSchedual.fromJson(
          await _courseSchedualRepository.getCourseSchedual(semester));
      emit(state.copywith(
          status: CourseSchedualStatus.success, schedual: courseSchedual));
    } on Exception {
      emit(state.copywith(status: CourseSchedualStatus.failure));
    }
  }

  @override
  CourseSchedualState fromJson(Map<String, dynamic> json) =>
      CourseSchedualState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(CourseSchedualState state) {
    return state.toJson();
  }
}
