import 'dart:io';

import 'package:collegenius/models/eeclass_model/EeclassAssignment.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/models/semester_model/semester_model.dart';
import 'package:eeclass_api/eeclass_api.dart';

class EeclassRepository {
  EeclassApiClient _eeclassApiClient = EeclassApiClient();
  String? username;
  String? password;

  void logout() {
    this._eeclassApiClient = new EeclassApiClient();
    username = null;
    password = null;
  }

  Future<bool> login(
      {required String username_, required String password_}) async {
    if (username == username_ && password == password_) {
      return true;
    }

    _eeclassApiClient.setAccount(id_: username_, password_: password_);
    final isLogIn = await _eeclassApiClient.logIn();
    if (isLogIn) {
      username = username_;
      password = password_;
    }
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

  Future<String> getCookiesStringForDownload() async {
    final cookies = await _eeclassApiClient.cookies();
    var cookiesString = '';
    for (Cookie cookie in cookies) {
      cookiesString += '${cookie.name}=${cookie.value};';
    }
    return cookiesString;
  }

  Future<List<Cookie>> getCookiesListForDownload() async {
    final cookies = await _eeclassApiClient.cookies();
    return cookies;
  }

  Future<List<EeclassCourseBrief>> getCourses({
    required String semester,
  }) async {
    final mapCourses = await _eeclassApiClient.getCourses(semester: semester);
    final List<EeclassCourseBrief> courses = [];
    mapCourses.forEach((element) {
      courses.add(EeclassCourseBrief.fromJson(element));
    });

    return courses;
  }

  Future<EeclassCourseInformation> getCourseInformation({
    required String courseSerial,
  }) async {
    final courseInformation = await _eeclassApiClient.getCourseInformation(
        courseSerial: courseSerial);
    return EeclassCourseInformation.fromJson(courseInformation);
  }

  Future<List<EeclassBullitinBrief>> getCourseBulletin({
    required String courseSerial,
    required int page,
  }) async {
    final courseBulletinJson = await _eeclassApiClient.getCourseBulletin(
        courseSerial: courseSerial, page: page);
    final List<EeclassBullitinBrief> courseBulletinList = [];
    courseBulletinJson.forEach((element) {
      courseBulletinList.add(EeclassBullitinBrief.fromJson(element));
    });

    return courseBulletinList;
  }

  Future<List<EeclassQuizBrief>> getCourseQuiz({
    required String courseSerial,
  }) async {
    final courseQuizJson =
        await _eeclassApiClient.getCourseQuiz(courseSerial: courseSerial);
    final List<EeclassQuizBrief> courseQuizList = [];
    courseQuizJson.forEach((element) {
      courseQuizList.add(EeclassQuizBrief.fromJson(element));
    });

    return courseQuizList;
  }

  Future<List<EeclassMaterialBrief>> getCourseMaterial({
    required String courseSerial,
  }) async {
    final courseMaterialJson =
        await _eeclassApiClient.getCourseMaterial(courseSerial: courseSerial);

    final List<EeclassMaterialBrief> courseMaterialList = [];
    courseMaterialJson.forEach((element) {
      courseMaterialList.add(EeclassMaterialBrief.fromJson(element));
    });

    return courseMaterialList;
  }

  Future<List<EeclassAssignmentBrief>> getCourseAssignment({
    required String courseSerial,
  }) async {
    final courseAssignmentJson =
        await _eeclassApiClient.getCourseAssignment(courseSerial: courseSerial);
    final List<EeclassAssignmentBrief> courseAssignmentList = [];
    courseAssignmentJson.forEach((element) {
      courseAssignmentList.add(EeclassAssignmentBrief.fromJson(element));
    });

    return courseAssignmentList;
  }

  Future<EeclassQuiz> getQuiz({
    required String url,
  }) async {
    final quizJson = await _eeclassApiClient.getQuiz(quizUrl: url);
    return EeclassQuiz.fromJson(quizJson);
  }

  Future<EeclassMaterial> getMaterial({
    required String type,
    required String url,
  }) async {
    final materialJson = await _eeclassApiClient.getMaterial(
      type: type,
      materialUrl: url,
    );
    return EeclassMaterial.fromJson(materialJson);
  }

  Future<EeclassAssignment> getAssignment({
    required String url,
  }) async {
    final assignmentJson =
        await _eeclassApiClient.getAssignment(assignmentUrl: url);
    return EeclassAssignment.fromJson(assignmentJson);
  }
}
