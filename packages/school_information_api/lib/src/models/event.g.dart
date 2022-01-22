// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      title: json['title'] as String?,
      category: json['category'] as String?,
      group: json['group'] as String?,
      time: json['time'] as String?,
      href: json['href'] as String?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'title': instance.title,
      'category': instance.category,
      'group': instance.group,
      'time': instance.time,
      'href': instance.href,
    };
