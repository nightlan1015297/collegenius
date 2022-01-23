// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      json['title'] as String?,
      json['href'] as String?,
      json['category'] as String?,
      json['group'] as String?,
      json['time'] as String?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'title': instance.title,
      'href': instance.href,
      'category': instance.category,
      'group': instance.group,
      'time': instance.time,
    };
