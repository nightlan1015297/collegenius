// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_schedual_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseSchedualState _$CoursepageStateFromJson(Map<String, dynamic> json) =>
    CourseSchedualState(
      status: $enumDecodeNullable(_$CoursepageStatusEnumMap, json['status']) ??
          CourseSchedualStatus.initial,
      schedual: json['schedual'] == null
          ? null
          : CourseSchedual.fromJson(json['schedual'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CoursepageStateToJson(CourseSchedualState instance) =>
    <String, dynamic>{
      'status': _$CoursepageStatusEnumMap[instance.status],
      'schedual': instance.schedual,
    };

const _$CoursepageStatusEnumMap = {
  CourseSchedualStatus.initial: 'initial',
  CourseSchedualStatus.loading: 'loading',
  CourseSchedualStatus.success: 'success',
  CourseSchedualStatus.failure: 'failure',
};
