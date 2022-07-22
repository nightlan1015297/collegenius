// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EeclassCourse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EeclassCourse _$EeclassCourseFromJson(Map<String, dynamic> json) =>
    EeclassCourse(
      classCode: json['classCode'] as String?,
      name: json['name'] as String?,
      credit: json['credit'] as String?,
      semester: json['semester'] as String?,
      division: json['division'] as String?,
      classes: json['classes'] as String?,
      members: json['members'] as String?,
      instroctors: json['instroctors'] as List<dynamic>?,
      assistants: json['assistants'] as List<dynamic>?,
      description: json['description'] as List<dynamic>?,
      syllabus: json['syllabus'] as List<dynamic>?,
      textbooks: json['textbooks'] as List<dynamic>?,
      gradingDescription: json['gradingDescription'] as List<dynamic>?,
    );

Map<String, dynamic> _$EeclassCourseToJson(EeclassCourse instance) =>
    <String, dynamic>{
      'classCode': instance.classCode,
      'name': instance.name,
      'credit': instance.credit,
      'semester': instance.semester,
      'division': instance.division,
      'classes': instance.classes,
      'members': instance.members,
      'instroctors': instance.instroctors,
      'assistants': instance.assistants,
      'description': instance.description,
      'syllabus': instance.syllabus,
      'textbooks': instance.textbooks,
      'gradingDescription': instance.gradingDescription,
    };
