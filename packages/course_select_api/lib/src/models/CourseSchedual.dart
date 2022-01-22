import 'package:course_select_api/src/models/CoursePerDay.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CourseSchedual.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class CourseSchedual {
  const CourseSchedual({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  final CoursePerDay monday;
  final CoursePerDay tuesday;
  final CoursePerDay wednesday;
  final CoursePerDay thursday;
  final CoursePerDay friday;
  final CoursePerDay saturday;
  final CoursePerDay sunday;

  factory CourseSchedual.fromJson(Map<String, dynamic> data) =>
      _$CourseSchedualFromJson(data);

  Map<String, dynamic> toJson() => _$CourseSchedualToJson(this);
}
