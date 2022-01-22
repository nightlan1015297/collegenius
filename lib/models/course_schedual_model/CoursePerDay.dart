import 'package:json_annotation/json_annotation.dart';
import 'Course.dart';
import 'package:equatable/equatable.dart';

part 'CoursePerDay.g.dart';

@JsonSerializable(explicitToJson: true)
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

  final Course? one;
  final Course? two;
  final Course? three;
  final Course? four;
  final Course? Z;
  final Course? five;
  final Course? six;
  final Course? seven;
  final Course? eight;
  final Course? nine;
  final Course? A;
  final Course? B;
  final Course? C;
  final Course? D;
  final Course? E;
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
