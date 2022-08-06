import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EeclassBullitinBrief.g.dart';

@JsonSerializable()
class EeclassBullitinBrief extends Equatable {
  final String title;
  final String url;
  final String readCount;
  final String auther;
  final String date;

  EeclassBullitinBrief({
    required this.title,
    required this.url,
    required this.readCount,
    required this.auther,
    required this.date,
  });

  factory EeclassBullitinBrief.fromJson(Map<String, dynamic> data) =>
      _$EeclassBullitinBriefFromJson(data);

  Map<String, dynamic> toJson() => _$EeclassBullitinBriefToJson(this);

  @override
  List<Object?> get props => [
        title,
        url,
        readCount,
        auther,
        date,
      ];
}
