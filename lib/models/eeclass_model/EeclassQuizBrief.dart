import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EeclassQuizBrief.g.dart';

@JsonSerializable()
class EeclassQuizBrief extends Equatable {
  final String title;
  final String url;
  final String deadLine;
  final double? score;

  EeclassQuizBrief(
      {required this.title,
      required this.url,
      required this.deadLine,
      this.score});

  factory EeclassQuizBrief.fromJson(Map<String, dynamic> data) =>
      _$EeclassQuizBriefFromJson(data);
  Map<String, dynamic> toJson() => _$EeclassQuizBriefToJson(this);
  @override
  List<Object?> get props => [
        title,
        url,
        deadLine,
        score,
      ];
}
