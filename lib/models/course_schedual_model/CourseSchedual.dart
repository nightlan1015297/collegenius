import 'package:hive/hive.dart';

import 'CoursePerDay.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CourseSchedual.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
@HiveType(typeId: 2)
class CourseSchedual extends Equatable {
  const CourseSchedual({
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });
  @HiveField(0)
  final CoursePerDay? monday;
  @HiveField(1)
  final CoursePerDay? tuesday;
  @HiveField(2)
  final CoursePerDay? wednesday;
  @HiveField(3)
  final CoursePerDay? thursday;
  @HiveField(4)
  final CoursePerDay? friday;
  @HiveField(5)
  final CoursePerDay? saturday;
  @HiveField(6)
  final CoursePerDay? sunday;

  static final empty = CourseSchedual();

  factory CourseSchedual.fromJson(Map<String, dynamic> data) =>
      _$CourseSchedualFromJson(data);

  Map<String, dynamic> toJson() => _$CourseSchedualToJson(this);

  @override
  List<Object?> get props =>
      [monday, tuesday, wednesday, thursday, friday, saturday, sunday];
}
