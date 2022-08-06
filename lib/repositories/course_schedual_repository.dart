import 'dart:async';
import 'package:collegenius/models/course_schedual_model/CourseSchedual.dart';
import 'package:collegenius/models/semester_model/semester_model.dart';
import 'package:course_select_api/course_select_api.dart';
import 'package:eeclass_api/eeclass_api.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// ***************************************************************************
///         COURSESCHEDUALREPOSITORY HANDELS ALL COURSE SCHEDUAL DATA.        *
/// THE DATA CAN BE FETCH FROM SERVER (COURSE SELECT API) OR READ FROM LOCAL. *
///            IT ALSO HANDELS FAKE DATA FOR TESTING PERPOSE TOO.             *
///****************************************************************************

class CourseSchedualRepository {
  CourseSchedualRepository();

  CourseSelectApiClient courseSelectApiClient = CourseSelectApiClient();

  Future<bool> login(
      {required String username, required String password}) async {
    var isLogIn = await courseSelectApiClient.checkLogInStatus();
    if (isLogIn) {
      return true;
    }
    courseSelectApiClient.setAccount(id_: username, password_: password);
    isLogIn = await courseSelectApiClient.checkLogInStatus();
    return isLogIn;
  }

  void logout() {
    this.courseSelectApiClient = new CourseSelectApiClient();
  }

  /// ! Function [getCourseSchedual] need to rewrite
  /// Since in condition(fetchFromLocal == true) will read data in CourseScheduals HiveBox
  /// without any authtication check, this may cause new Authenticated user
  /// reads old user's data.

  Future<CourseSchedual?> getCourseSchedual(
      {required bool fromLocal, required String semester}) async {
    final _courseSchedual;
    var _schedualbox = await Hive.openBox<CourseSchedual>('CourseScheduals');
    if (!fromLocal) {
      _courseSchedual = await courseSelectApiClient.getCourseschedual(semester);
      _schedualbox.put(semester, CourseSchedual.fromJson(_courseSchedual));
      _schedualbox.close();
      return CourseSchedual.fromJson(_courseSchedual);
    }
    _courseSchedual = _schedualbox.get(semester);
    _schedualbox.close();
    if (_courseSchedual == null) {
      return null;
    }
    return _courseSchedual;
  }

  Future<String?> getCurrentSemester() async {
    final currentSemester = await courseSelectApiClient.getCurrentSemester();
    return currentSemester;
  }

  Future<List<Semester>> getSemesterList({required bool fromLocal}) async {
    var _semesterbox = await Hive.openBox<Semester>('semesters');
    if (_semesterbox.isNotEmpty) {
      return _semesterbox.values.toList();
    } else {
      if (fromLocal) {
        return _semesterbox.values.toList();
      } else {
        final semesters = await courseSelectApiClient.getSemesterList();
        for (var item in semesters) {
          _semesterbox.add(Semester()
            ..name = item
            ..value = item);
        }
        return _semesterbox.values.toList();
      }
    }
  }
}
