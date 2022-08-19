import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;

class RequestToServerFailed implements Exception {}

class LogInFailed implements Exception {}

class IndexNotExists implements Exception {}

class DataLoadFailed implements Exception {}

class UnAuthenticatedFailure implements Exception {}

class NotReadyFailure implements Exception {}

String indexToCode(int index) {
  switch (index) {
    case 1:
      return 'one';
    case 2:
      return 'two';
    case 3:
      return 'three';
    case 4:
      return 'four';
    case 5:
      return 'Z';
    case 6:
      return 'five';
    case 7:
      return 'six';
    case 8:
      return 'seven';
    case 9:
      return 'eight';
    case 10:
      return 'nine';
    case 11:
      return 'A';
    case 12:
      return 'B';
    case 13:
      return 'C';
    case 14:
      return 'D';
    case 15:
      return 'E';
    case 16:
      return 'F';
    default:
      throw IndexNotExists();
  }
}

String indexToDays(int index) {
  switch (index) {
    case 0:
      return 'sunday';
    case 1:
      return 'monday';
    case 2:
      return 'tuesday';
    case 3:
      return 'wednesday';
    case 4:
      return 'thursday';
    case 5:
      return 'friday';
    case 6:
      return 'saturday';
    default:
      throw IndexNotExists();
  }
}

class CourseSelectApiClient {
  CourseSelectApiClient() {
    dio.interceptors.add(CookieManager(cookieJar));
  }

  final String url = 'https://cis.ncu.edu.tw/Course/main';

  bool isLogIn = false;
  bool isInitialize = false;

  var dio = Dio();
  var cookieJar = CookieJar();
  String? id;
  String? password;

  void setAccount({required String id_, required String password_}) {
    id = id_;
    password = password_;
    isInitialize = true;
  }

  Future<bool> checkLogInStatus() async {
    var response = await dio.get(url + '/login');
    if (response.redirects.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  /* Function that used to Login to the eeclass system */

  Future<bool> logIn() async {
    var status = await checkLogInStatus();
    if (status == true) {
      return true;
    }
    var response = await dio.post(url + '/login',
        data: FormData.fromMap({
          'submit': '登入',
          'account': id,
          'passwd': password,
        }));
    if (response.statusCode != 200) {
      id = null;
      password = null;
      throw RequestToServerFailed();
    }
    if (!await checkLogInStatus()) {
      throw LogInFailed();
    }
    return true;
  }

  Future<bool> readyToFetch() async {
    if (!isInitialize) {
      throw UnAuthenticatedFailure();
    }
    var status = await checkLogInStatus();
    if (status == true) {
      return true;
    } else {
      return await logIn();
    }
  }

  Future<Map<String, dynamic>> getCourseschedual(String semester) async {
    if (!await readyToFetch()) {
      throw NotReadyFailure();
    }
    var response = await dio.post(url + '/personal/A4Crstable',
        data: FormData.fromMap({
          'semester': semester,
        }));

    dom.Document document = htmlparser.parse(response.data.toString());
    var table = document.getElementsByClassName('classtable')[0];
    var rows = table.getElementsByTagName('tr');

    final Map<String, dynamic> data = {
      'monday': <String, dynamic>{},
      'tuesday': <String, dynamic>{},
      'wednesday': <String, dynamic>{},
      'thursday': <String, dynamic>{},
      'friday': <String, dynamic>{},
      'saturday': <String, dynamic>{},
      'sunday': <String, dynamic>{},
    };
    for (int i = 1; i < rows.length; i++) {
      var elemInRow = rows[i].getElementsByTagName('td');
      for (int j = 0; j < elemInRow.length; j++) {
        var info = elemInRow[j].text.trim().split('\n');
        Map<String, dynamic>? temp;
        if (info.length != 1) {
          var target = info[1].trim().replaceAll(RegExp(r'[()]'), "");
          var _ = target.split('/');
          if (_[0].trim().startsWith(RegExp(r'.*[A-Z]+.*[0-9]+.*'))) {
            temp = {
              'name': info[0].trim(),
              'classroom': _[0].trim(),
              'professer': _[1].trim(),
            };
          } else {
            temp = {
              'name': info[0].trim(),
              'classroom': _[1].trim(),
              'professer': _[0].trim(),
            };
          }
          data[indexToDays(j)][indexToCode(i)] = temp;
        }
      }
    }
    return data;
  }

  Future<String> getCurrentSemester() async {
    var response = await dio.get(url + '/news/announce');
    dom.Document document = htmlparser.parse(response.data.toString());
    var targetBanner = document.getElementsByClassName('intro_banner')[1];
    return targetBanner.text.split('|')[0].trim();
  }

  Future<List<String>> getSemesterList() async {
    if (!await readyToFetch()) {
      throw NotReadyFailure();
    }
    var response = await dio.get(
      url + '/personal/A4Crstable',
    );
    dom.Document document = htmlparser.parse(response.data.toString());
    var target = document.getElementsByTagName("select")[0].children;
    var result = target.map((e) => e.text).toList();
    return result;
  }
}
