import 'package:collegenius/models/course_schedual_model/Course.dart';
import 'package:eeclass_api/eeclass_api.dart';

import '../models/eeclass_model/EeclassCourse.dart';
import '../models/semester_model/semester_model.dart';

class UnInitializeError implements Exception {}

class EeclassRepository {
  final EeclassApiClient _eeclassApiClient = EeclassApiClient();

  Future<bool> login(
      {required String username, required String password}) async {
    var isLogIn = await _eeclassApiClient.checkLogInStatus();
    if (isLogIn) {
      return true;
    }
    _eeclassApiClient.setAccount(id_: username, password_: password);
    _eeclassApiClient.logIn();
    isLogIn = await _eeclassApiClient.checkLogInStatus();
    return isLogIn;
  }

  Future<List<Semester>> getAvaliableSemester() async {
    final semesters = await _eeclassApiClient.getAvalibleSemester();
    final List<Semester> semesterList = [];
    semesters.forEach((key, value) {
      semesterList.add(Semester()
        ..name = key
        ..value = value);
    });
    return semesterList;
  }

  Future<List<EeclassCourse>> getCourses(String semester) async {
    final mapCourses = await _eeclassApiClient.getCourses(semester: semester);
    final List<EeclassCourse> courses = [];
    mapCourses.forEach((element) {
      courses.add(EeclassCourse.fromJson(element));
    });
    return courses;
  }
}
