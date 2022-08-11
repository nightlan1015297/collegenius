import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EeclassAssignmentBrief.g.dart';

@JsonSerializable()
class EeclassAssignmentBrief extends Equatable {
  final String title;
  final String url;
  final bool isTeamHomework;
  final String startHandInDate;
  final String deadline;
  final bool isHandedOn;
  final double? score;

  EeclassAssignmentBrief(
      {required this.title,
      required this.url,
      required this.isTeamHomework,
      required this.startHandInDate,
      required this.deadline,
      required this.isHandedOn,
      required this.score});

  factory EeclassAssignmentBrief.fromJson(Map<String, dynamic> data) =>
      _$EeclassAssignmentBriefFromJson(data);

  Map<String, dynamic> toJson() => _$EeclassAssignmentBriefToJson(this);

  @override
  List<Object?> get props => [
        title,
        url,
        isTeamHomework,
        startHandInDate,
        deadline,
        isHandedOn,
        score,
      ];
}
