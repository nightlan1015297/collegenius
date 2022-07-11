// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CourseSchedual.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseSchedualAdapter extends TypeAdapter<CourseSchedual> {
  @override
  final int typeId = 2;

  @override
  CourseSchedual read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseSchedual(
      sunday: fields[6] as CoursePerDay?,
      monday: fields[0] as CoursePerDay?,
      tuesday: fields[1] as CoursePerDay?,
      wednesday: fields[2] as CoursePerDay?,
      thursday: fields[3] as CoursePerDay?,
      friday: fields[4] as CoursePerDay?,
      saturday: fields[5] as CoursePerDay?,
    );
  }

  @override
  void write(BinaryWriter writer, CourseSchedual obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.monday)
      ..writeByte(1)
      ..write(obj.tuesday)
      ..writeByte(2)
      ..write(obj.wednesday)
      ..writeByte(3)
      ..write(obj.thursday)
      ..writeByte(4)
      ..write(obj.friday)
      ..writeByte(5)
      ..write(obj.saturday)
      ..writeByte(6)
      ..write(obj.sunday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseSchedualAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseSchedual _$CourseSchedualFromJson(Map json) => CourseSchedual(
      sunday: json['sunday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['sunday'] as Map)),
      monday: json['monday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['monday'] as Map)),
      tuesday: json['tuesday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['tuesday'] as Map)),
      wednesday: json['wednesday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['wednesday'] as Map)),
      thursday: json['thursday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['thursday'] as Map)),
      friday: json['friday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['friday'] as Map)),
      saturday: json['saturday'] == null
          ? null
          : CoursePerDay.fromJson(
              Map<String, dynamic>.from(json['saturday'] as Map)),
    );

Map<String, dynamic> _$CourseSchedualToJson(CourseSchedual instance) =>
    <String, dynamic>{
      'monday': instance.monday?.toJson(),
      'tuesday': instance.tuesday?.toJson(),
      'wednesday': instance.wednesday?.toJson(),
      'thursday': instance.thursday?.toJson(),
      'friday': instance.friday?.toJson(),
      'saturday': instance.saturday?.toJson(),
      'sunday': instance.sunday?.toJson(),
    };
