import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EeclassBullitin.g.dart';

@JsonSerializable()
class EeclassBullitin extends Equatable {
  final List content;
  final List fileList;

  EeclassBullitin({required this.content, required this.fileList});

  factory EeclassBullitin.fromJson(Map<String, dynamic> data) =>
      _$EeclassBullitinFromJson(data);
  Map<String, dynamic> toJson() => _$EeclassBullitinToJson(this);

  @override
  List<Object?> get props => [
        content,
        fileList,
      ];
}
