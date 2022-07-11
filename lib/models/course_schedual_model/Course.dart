import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'Course.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class Course extends Equatable {
  const Course(
      {required this.name, required this.classroom, required this.professer});
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? classroom;
  @HiveField(2)
  final String? professer;

  factory Course.fromJson(Map<String, dynamic> data) => _$CourseFromJson(data);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  @override
  List<Object?> get props => [name, classroom, professer];
}
