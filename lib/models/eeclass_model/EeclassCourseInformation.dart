import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EeclassCourseInformation.g.dart';

@JsonSerializable()
class EeclassCourseInformation extends Equatable {
  const EeclassCourseInformation({
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
  final String? description;
  final String? syllabus;
  final String? textbooks;
  final String? gradingDescription;

  factory EeclassCourseInformation.fromJson(Map<String, dynamic> data) =>
      _$EeclassCourseInformationFromJson(data);
  Map<String, dynamic> toJson() => _$EeclassCourseInformationToJson(this);

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
