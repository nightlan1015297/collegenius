// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SchoolEvent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolEvent _$SchoolEventFromJson(Map<String, dynamic> json) => SchoolEvent(
      json['title'] as String?,
      json['href'] as String?,
      json['category'] as String?,
      json['group'] as String?,
      json['time'] as String?,
    );

Map<String, dynamic> _$SchoolEventToJson(SchoolEvent instance) =>
    <String, dynamic>{
      'title': instance.title,
      'href': instance.href,
      'category': instance.category,
      'group': instance.group,
      'time': instance.time,
    };
