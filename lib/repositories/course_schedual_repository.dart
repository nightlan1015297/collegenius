import 'dart:async';
import 'package:collegenius/models/course_schedual_model/CourseSchedual.dart';
import 'package:collegenius/models/semester_model/semester_model.dart';
import 'package:collegenius/utilties/PathGenerator.dart';
import 'package:course_select_api/course_select_api.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// ***************************************************************************
///         COURSESCHEDUALREPOSITORY HANDELS ALL COURSE SCHEDUAL DATA.        *
/// THE DATA CAN BE FETCH FROM SERVER (COURSE SELECT API) OR READ FROM LOCAL. *
///****************************************************************************

class CourseSchedualRepository {
  CourseSchedualRepository();

  String? username;
  String? password;
  CourseSelectApiClient courseSelectApiClient = CourseSelectApiClient();

  Future<bool> login(
      {required String username_, required String password_}) async {
    if (username == username_ && password == password_) {
      return true;
    }
    courseSelectApiClient.setAccount(id_: username_, password_: password_);

    final isLogIn = await courseSelectApiClient.logIn();
    if (isLogIn) {
      username = username_;
      password = password_;
    }
    return isLogIn;
  }

  void logout() async {
    username = null;
    password = null;
    final hiveDb = await PathGenerator().getHiveDatabaseDirectory();
    hiveDb.delete(recursive: true);
    this.courseSelectApiClient = new CourseSelectApiClient();
  }

  Future<CourseSchedual?> getCourseSchedual(
      {required bool fromLocal, required String semester}) async {
    final _courseSchedual;
    var _schedualbox = await Hive.openBox<CourseSchedual>('CourseScheduals');
    if (!fromLocal) {
      _courseSchedual = await courseSelectApiClient.getCourseschedual(semester);
      _schedualbox.put(semester, CourseSchedual.fromJson(_courseSchedual));
      _schedualbox.close();
      return CourseSchedual.fromJson(_courseSchedual);
    } else {
      _courseSchedual = _schedualbox.get(semester);
      _schedualbox.close();
    }
    return _courseSchedual;
  }

  Future<String> getCurrentSemester({required bool fromLocal}) async {
    if (fromLocal) {
      return "1111";
    }
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
