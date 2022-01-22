import 'package:json_annotation/json_annotation.dart';

part 'Course.g.dart';

@JsonSerializable()
class Course {
  const Course(
      {required this.name, required this.classroom, required this.professer});

  final String? name;
  final String? classroom;
  final String? professer;

  factory Course.fromJson(Map<String, dynamic> data) => _$CourseFromJson(data);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
