import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SchoolEvent.g.dart';

@JsonSerializable()
class SchoolEvent extends Equatable {
  final String? title;
  final String? href;
  final String? category;
  final String? group;
  final String? time;

  factory SchoolEvent.fromJson(Map<String, dynamic> data) =>
      _$SchoolEventFromJson(data);

  SchoolEvent(
    this.title,
    this.href,
    this.category,
    this.group,
    this.time,
  );

  Map<String, dynamic> toJson() => _$SchoolEventToJson(this);

  @override
  List<Object?> get props => [title, href, category, group, time];
}
