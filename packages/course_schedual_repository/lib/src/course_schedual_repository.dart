import 'dart:async';
import 'package:course_select_api/course_select_api.dart'
    hide Course, CoursePerDay, CourseSchedual;

class CourseSchedualFailure implements Exception {}

class CourseSchedualRepository {
  CourseSchedualRepository({username, password})
      : _courseSelectApiClient =
            CourseSelectApiClient(name: 'username', password: 'password');
  final CourseSelectApiClient _courseSelectApiClient;

  Future<Map<String, dynamic>> getCourseSchedual(String semester) async {
    final _courseSchedual =
        await _courseSelectApiClient.getCourseschedual(semester);
    return _courseSchedual.toJson();
  }
}
