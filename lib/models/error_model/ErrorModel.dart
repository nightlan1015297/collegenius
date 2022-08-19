import 'package:json_annotation/json_annotation.dart';

part 'ErrorModel.g.dart';

@JsonSerializable()
class ErrorModel {
  ErrorModel({
    required this.exception,
    required this.stackTrace,
  });
  final String exception;
  final String stackTrace;

  factory ErrorModel.fromJson(Map<String, dynamic> data) =>
      _$ErrorModelFromJson(data);

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}
