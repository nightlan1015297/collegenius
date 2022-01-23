import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Event.g.dart';

@JsonSerializable()
class Event extends Equatable {
  final String? title;
  final String? href;
  final String? category;
  final String? group;
  final String? time;

  factory Event.fromJson(Map<String, dynamic> data) => _$EventFromJson(data);

  Event(
    this.title,
    this.href,
    this.category,
    this.group,
    this.time,
  );

  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  List<Object?> get props => [title, href, category, group, time];
}
