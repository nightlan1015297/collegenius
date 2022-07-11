import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'Course.dart';
import 'package:equatable/equatable.dart';

part 'CoursePerDay.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class CoursePerDay extends Equatable {
  const CoursePerDay(
      {this.one,
      this.two,
      this.three,
      this.four,
      this.Z,
      this.five,
      this.six,
      this.seven,
      this.eight,
      this.nine,
      this.A,
      this.B,
      this.C,
      this.D,
      this.E,
      this.F});
  @HiveField(0)
  final Course? one;
  @HiveField(1)
  final Course? two;
  @HiveField(2)
  final Course? three;
  @HiveField(3)
  final Course? four;
  @HiveField(4)
  final Course? Z;
  @HiveField(5)
  final Course? five;
  @HiveField(6)
  final Course? six;
  @HiveField(7)
  final Course? seven;
  @HiveField(8)
  final Course? eight;
  @HiveField(9)
  final Course? nine;
  @HiveField(10)
  final Course? A;
  @HiveField(11)
  final Course? B;
  @HiveField(12)
  final Course? C;
  @HiveField(13)
  final Course? D;
  @HiveField(14)
  final Course? E;
  @HiveField(15)
  final Course? F;

  factory CoursePerDay.fromJson(Map<String, dynamic> data) =>
      _$CoursePerDayFromJson(data);

  Map<String, dynamic> toJson() => _$CoursePerDayToJson(this);

  @override
  List<Object?> get props => [
        one,
        two,
        three,
        four,
        Z,
        five,
        six,
        seven,
        eight,
        nine,
        A,
        B,
        C,
        D,
        E,
        F
      ];
}
