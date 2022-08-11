// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EeclassQuizBrief.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EeclassQuizBrief _$EeclassQuizBriefFromJson(Map<String, dynamic> json) =>
    EeclassQuizBrief(
      title: json['title'] as String,
      url: json['url'] as String,
      deadLine: json['deadLine'] as String,
      score: (json['score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EeclassQuizBriefToJson(EeclassQuizBrief instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'deadLine': instance.deadLine,
      'score': instance.score,
    };
