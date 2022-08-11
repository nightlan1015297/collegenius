import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EeclassMaterial.g.dart';

@JsonSerializable()
class EeclassMaterial extends Equatable {
  final String? description;
  final List? fileList;
  final String? source;

  EeclassMaterial({this.description, this.fileList, this.source});
  factory EeclassMaterial.fromJson(Map<String, dynamic> data) =>
      _$EeclassMaterialFromJson(data);

  Map<String, dynamic> toJson() => _$EeclassMaterialToJson(this);
  @override
  List<Object?> get props => [
        description,
        fileList,
        source,
      ];
}
