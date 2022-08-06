// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EeclassAssignmentBrief.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EeclassAssignmentBrief _$EeclassAssignmentBriefFromJson(
        Map<String, dynamic> json) =>
    EeclassAssignmentBrief(
      title: json['title'] as String,
      url: json['url'] as String,
      isTeamHomework: json['isTeamHomework'] as bool,
      startHandInDate: json['startHandInDate'] as String,
      deadline: json['deadline'] as String,
      isHandedOn: json['isHandedOn'] as bool,
      score: json['score'] as String,
    );

Map<String, dynamic> _$EeclassAssignmentBriefToJson(
        EeclassAssignmentBrief instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'isTeamHomework': instance.isTeamHomework,
      'startHandInDate': instance.startHandInDate,
      'deadline': instance.deadline,
      'isHandedOn': instance.isHandedOn,
      'score': instance.score,
    };
