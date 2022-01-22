import 'CoursePerDay.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CourseSchedual.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
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

  final CoursePerDay? monday;
  final CoursePerDay? tuesday;
  final CoursePerDay? wednesday;
  final CoursePerDay? thursday;
  final CoursePerDay? friday;
  final CoursePerDay? saturday;
  final CoursePerDay? sunday;

  static final empty = CourseSchedual();

  factory CourseSchedual.fromJson(Map<String, dynamic> data) =>
      _$CourseSchedualFromJson(data);

  Map<String, dynamic> toJson() => _$CourseSchedualToJson(this);

  @override
  List<Object?> get props =>
      [monday, tuesday, wednesday, thursday, friday, saturday, sunday];
}
