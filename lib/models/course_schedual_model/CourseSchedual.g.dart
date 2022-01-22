// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CourseSchedual.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseSchedual _$CourseSchedualFromJson(Map json) => CourseSchedual(
      sunday: json['sunday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['sunday'] as Map)),
      monday: json['monday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['monday'] as Map)),
      tuesday: json['tuesday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['tuesday'] as Map)),
      wednesday: json['wednesday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['wednesday'] as Map)),
      thursday: json['thursday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['thursday'] as Map)),
      friday: json['friday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['friday'] as Map)),
      saturday: json['saturday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['saturday'] as Map)),
    );

Map<String, dynamic> _$CourseSchedualToJson(CourseSchedual instance) =>
    <String, dynamic>{
      'monday': instance.monday?.toJson(),
      'tuesday': instance.tuesday?.toJson(),
      'wednesday': instance.wednesday?.toJson(),
      'thursday': instance.thursday?.toJson(),
      'friday': instance.friday?.toJson(),
      'saturday': instance.saturday?.toJson(),
      'sunday': instance.sunday?.toJson(),
    };
