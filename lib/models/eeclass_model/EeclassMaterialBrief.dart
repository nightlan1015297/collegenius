import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EeclassMaterialBrief.g.dart';

@JsonSerializable()
class EeclassMaterialBrief extends Equatable {
  final String title;
  final String url;
  final String readCount;
  final String discussion;
  final String auther;
  final String updateDate;
  final String type;

  EeclassMaterialBrief({
    required this.title,
    required this.url,
    required this.readCount,
    required this.discussion,
    required this.auther,
    required this.updateDate,
    required this.type,
  });
  factory EeclassMaterialBrief.fromJson(Map<String, dynamic> data) =>
      _$EeclassMaterialBriefFromJson(data);

  Map<String, dynamic> toJson() => _$EeclassMaterialBriefToJson(this);
  @override
  List<Object?> get props => [
        title,
        url,
        readCount,
        discussion,
        auther,
        updateDate,
        type,
      ];
}
