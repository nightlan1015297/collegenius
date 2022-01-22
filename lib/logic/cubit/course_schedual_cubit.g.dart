// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_schedual_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseSchedualState _$CourseSchedualStateFromJson(Map<String, dynamic> json) =>
    CourseSchedualState(
      status:
          $enumDecodeNullable(_$CourseSchedualStatusEnumMap, json['status']) ??
              CourseSchedualStatus.initial,
      schedual: json['schedual'] == null
          ? null
          : CourseSchedual.fromJson(json['schedual'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseSchedualStateToJson(
        CourseSchedualState instance) =>
    <String, dynamic>{
      'status': _$CourseSchedualStatusEnumMap[instance.status],
      'schedual': instance.schedual,
    };

const _$CourseSchedualStatusEnumMap = {
  CourseSchedualStatus.initial: 'initial',
  CourseSchedualStatus.loading: 'loading',
  CourseSchedualStatus.success: 'success',
  CourseSchedualStatus.failure: 'failure',
};
