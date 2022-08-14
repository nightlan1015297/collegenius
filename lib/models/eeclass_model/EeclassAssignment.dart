import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EeclassAssignment.g.dart';

@JsonSerializable()
class EeclassAssignment extends Equatable {
  final String? allowUploadDate;
  final String? hasUploadedPeople;
  final String? deadline;
  final bool? canDelay;
  final String? percentage;
  final String? gradingMethod;
  final String? description;
  final List? fileList;

  EeclassAssignment(
      this.allowUploadDate,
      this.hasUploadedPeople,
      this.deadline,
      this.canDelay,
      this.percentage,
      this.gradingMethod,
      this.description,
      this.fileList);
  factory EeclassAssignment.fromJson(Map<String, dynamic> data) =>
      _$EeclassAssignmentFromJson(data);

  Map<String, dynamic> toJson() => _$EeclassAssignmentToJson(this);

  @override
  List<Object?> get props => [
        allowUploadDate,
        hasUploadedPeople,
        deadline,
        canDelay,
        percentage,
        gradingMethod,
        description,
        fileList,
      ];
}
