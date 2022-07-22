import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EeclassCourse.g.dart';

@JsonSerializable()
class EeclassCourse extends Equatable {
  const EeclassCourse({
    this.classCode,
    this.name,
    this.credit,
    this.semester,
    this.division,
    this.classes,
    this.members,
    this.instroctors,
    this.assistants,
    this.description,
    this.syllabus,
    this.textbooks,
    this.gradingDescription,
  });
  final String? classCode;
  final String? name;
  final String? credit;
  final String? semester;
  final String? division;
  final String? classes;
  final String? members;
  final List? instroctors;
  final List? assistants;
  final List? description;
  final List? syllabus;
  final List? textbooks;
  final List? gradingDescription;

  factory EeclassCourse.fromJson(Map<String, dynamic> data) =>
      _$EeclassCourseFromJson(data);
  Map<String, dynamic> toJson() => _$EeclassCourseToJson(this);
  @override
  List<Object?> get props => [
        classCode,
        name,
        credit,
        semester,
        division,
        classes,
        members,
        instroctors,
        assistants,
        description,
        syllabus,
        textbooks,
        gradingDescription
      ];
}
