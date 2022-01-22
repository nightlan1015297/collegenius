import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final String? title;
  final String? category;
  final String? group;
  final String? time;
  final String? href;
  Event({
    this.title,
    this.category,
    this.group,
    this.time,
    this.href,
  });

  factory Event.fromJson(Map<String, dynamic> data) => _$EventFromJson(data);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
