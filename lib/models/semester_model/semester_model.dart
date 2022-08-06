import 'package:hive/hive.dart';

part 'semester_model.g.dart';

@HiveType(typeId: 0)
class Semester extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String value;

  @override
  String toString() {
    return "name : $name, value : $value";
  }
}
