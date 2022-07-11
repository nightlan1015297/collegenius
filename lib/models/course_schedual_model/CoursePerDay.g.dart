// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CoursePerDay.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoursePerDayAdapter extends TypeAdapter<CoursePerDay> {
  @override
  final int typeId = 1;

  @override
  CoursePerDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoursePerDay(
      one: fields[0] as Course?,
      two: fields[1] as Course?,
      three: fields[2] as Course?,
      four: fields[3] as Course?,
      Z: fields[4] as Course?,
      five: fields[5] as Course?,
      six: fields[6] as Course?,
      seven: fields[7] as Course?,
      eight: fields[8] as Course?,
      nine: fields[9] as Course?,
      A: fields[10] as Course?,
      B: fields[11] as Course?,
      C: fields[12] as Course?,
      D: fields[13] as Course?,
      E: fields[14] as Course?,
      F: fields[15] as Course?,
    );
  }

  @override
  void write(BinaryWriter writer, CoursePerDay obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.one)
      ..writeByte(1)
      ..write(obj.two)
      ..writeByte(2)
      ..write(obj.three)
      ..writeByte(3)
      ..write(obj.four)
      ..writeByte(4)
      ..write(obj.Z)
      ..writeByte(5)
      ..write(obj.five)
      ..writeByte(6)
      ..write(obj.six)
      ..writeByte(7)
      ..write(obj.seven)
      ..writeByte(8)
      ..write(obj.eight)
      ..writeByte(9)
      ..write(obj.nine)
      ..writeByte(10)
      ..write(obj.A)
      ..writeByte(11)
      ..write(obj.B)
      ..writeByte(12)
      ..write(obj.C)
      ..writeByte(13)
      ..write(obj.D)
      ..writeByte(14)
      ..write(obj.E)
      ..writeByte(15)
      ..write(obj.F);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoursePerDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursePerDay _$CoursePerDayFromJson(Map<String, dynamic> json) => CoursePerDay(
      one: json['one'] == null
          ? null
          : Course.fromJson(json['one'] as Map<String, dynamic>),
      two: json['two'] == null
          ? null
          : Course.fromJson(json['two'] as Map<String, dynamic>),
      three: json['three'] == null
          ? null
          : Course.fromJson(json['three'] as Map<String, dynamic>),
      four: json['four'] == null
          ? null
          : Course.fromJson(json['four'] as Map<String, dynamic>),
      Z: json['Z'] == null
          ? null
          : Course.fromJson(json['Z'] as Map<String, dynamic>),
      five: json['five'] == null
          ? null
          : Course.fromJson(json['five'] as Map<String, dynamic>),
      six: json['six'] == null
          ? null
          : Course.fromJson(json['six'] as Map<String, dynamic>),
      seven: json['seven'] == null
          ? null
          : Course.fromJson(json['seven'] as Map<String, dynamic>),
      eight: json['eight'] == null
          ? null
          : Course.fromJson(json['eight'] as Map<String, dynamic>),
      nine: json['nine'] == null
          ? null
          : Course.fromJson(json['nine'] as Map<String, dynamic>),
      A: json['A'] == null
          ? null
          : Course.fromJson(json['A'] as Map<String, dynamic>),
      B: json['B'] == null
          ? null
          : Course.fromJson(json['B'] as Map<String, dynamic>),
      C: json['C'] == null
          ? null
          : Course.fromJson(json['C'] as Map<String, dynamic>),
      D: json['D'] == null
          ? null
          : Course.fromJson(json['D'] as Map<String, dynamic>),
      E: json['E'] == null
          ? null
          : Course.fromJson(json['E'] as Map<String, dynamic>),
      F: json['F'] == null
          ? null
          : Course.fromJson(json['F'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CoursePerDayToJson(CoursePerDay instance) =>
    <String, dynamic>{
      'one': instance.one?.toJson(),
      'two': instance.two?.toJson(),
      'three': instance.three?.toJson(),
      'four': instance.four?.toJson(),
      'Z': instance.Z?.toJson(),
      'five': instance.five?.toJson(),
      'six': instance.six?.toJson(),
      'seven': instance.seven?.toJson(),
      'eight': instance.eight?.toJson(),
      'nine': instance.nine?.toJson(),
      'A': instance.A?.toJson(),
      'B': instance.B?.toJson(),
      'C': instance.C?.toJson(),
      'D': instance.D?.toJson(),
      'E': instance.E?.toJson(),
      'F': instance.F?.toJson(),
    };
