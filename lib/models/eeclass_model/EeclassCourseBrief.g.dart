// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EeclassCourseBrief.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EeclassCourseBrief _$EeclassCourseBriefFromJson(Map<String, dynamic> json) =>
    EeclassCourseBrief(
      name: json['name'] as String,
      credit: json['credit'] as String?,
      professor: json['professor'] as String?,
      courseCode: json['courseCode'] as String?,
      courseSerial: json['courseSerial'] as String,
    );

Map<String, dynamic> _$EeclassCourseBriefToJson(EeclassCourseBrief instance) =>
    <String, dynamic>{
      'name': instance.name,
      'credit': instance.credit,
      'professor': instance.professor,
      'courseCode': instance.courseCode,
      'courseSerial': instance.courseSerial,
    };
