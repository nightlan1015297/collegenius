// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EeclassAssignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EeclassAssignment _$EeclassAssignmentFromJson(Map<String, dynamic> json) =>
    EeclassAssignment(
      json['allowUploadDate'] as String?,
      json['hasUploadedPeople'] as String?,
      json['deadline'] as String?,
      json['canDelay'] as bool?,
      json['percentage'] as String?,
      json['gradingMethod'] as String?,
      json['description'] as String?,
      json['fileList'] as List<dynamic>?,
    );

Map<String, dynamic> _$EeclassAssignmentToJson(EeclassAssignment instance) =>
    <String, dynamic>{
      'allowUploadDate': instance.allowUploadDate,
      'hasUploadedPeople': instance.hasUploadedPeople,
      'deadline': instance.deadline,
      'canDelay': instance.canDelay,
      'percentage': instance.percentage,
      'gradingMethod': instance.gradingMethod,
      'description': instance.description,
      'fileList': instance.fileList,
    };
