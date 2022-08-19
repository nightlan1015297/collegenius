// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ErrorModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorModel _$ErrorModelFromJson(Map<String, dynamic> json) => ErrorModel(
      exception: json['exception'] as String,
      stackTrace: json['stackTrace'] as String,
    );

Map<String, dynamic> _$ErrorModelToJson(ErrorModel instance) =>
    <String, dynamic>{
      'exception': instance.exception,
      'stackTrace': instance.stackTrace,
    };
