import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EeclassCourseBrief.g.dart';

@JsonSerializable()
class EeclassCourseBrief extends Equatable {
  const EeclassCourseBrief({
    this.name,
    this.credit,
    this.professor,
    this.courseCode,
    this.courseSerial,
  });

  final String? name;
  final String? credit;
  final String? professor;
  final String? courseCode;
  final String? courseSerial;

  factory EeclassCourseBrief.fromJson(Map<String, dynamic> data) =>
      _$EeclassCourseBriefFromJson(data);

  Map<String, dynamic> toJson() => _$EeclassCourseBriefToJson(this);

  @override
  List<Object?> get props =>
      [name, credit, professor, courseCode, courseSerial];
}
