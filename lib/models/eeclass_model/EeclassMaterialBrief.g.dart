// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EeclassMaterialBrief.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EeclassMaterialBrief _$EeclassMaterialBriefFromJson(
        Map<String, dynamic> json) =>
    EeclassMaterialBrief(
      title: json['title'] as String,
      url: json['url'] as String,
      readCount: json['readCount'] as String,
      discussion: json['discussion'] as String,
      auther: json['auther'] as String,
      updateDate: json['updateDate'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$EeclassMaterialBriefToJson(
        EeclassMaterialBrief instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'readCount': instance.readCount,
      'discussion': instance.discussion,
      'auther': instance.auther,
      'updateDate': instance.updateDate,
      'type': instance.type,
    };
