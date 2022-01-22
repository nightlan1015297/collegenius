// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CourseSchedual.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseSchedual _$CourseSchedualFromJson(Map json) => CourseSchedual(
      sunday: CoursePerDay.fromJson(
          Map<String, dynamic>.from(json['sunday'] as Map)),
      monday: CoursePerDay.fromJson(
          Map<String, dynamic>.from(json['monday'] as Map)),
      tuesday: CoursePerDay.fromJson(
          Map<String, dynamic>.from(json['tuesday'] as Map)),
      wednesday: CoursePerDay.fromJson(
          Map<String, dynamic>.from(json['wednesday'] as Map)),
      thursday: CoursePerDay.fromJson(
          Map<String, dynamic>.from(json['thursday'] as Map)),
      friday: CoursePerDay.fromJson(
          Map<String, dynamic>.from(json['friday'] as Map)),
      saturday: CoursePerDay.fromJson(
          Map<String, dynamic>.from(json['saturday'] as Map)),
    );

Map<String, dynamic> _$CourseSchedualToJson(CourseSchedual instance) =>
    <String, dynamic>{
      'monday': instance.monday.toJson(),
      'tuesday': instance.tuesday.toJson(),
      'wednesday': instance.wednesday.toJson(),
      'thursday': instance.thursday.toJson(),
      'friday': instance.friday.toJson(),
      'saturday': instance.saturday.toJson(),
      'sunday': instance.sunday.toJson(),
    };
