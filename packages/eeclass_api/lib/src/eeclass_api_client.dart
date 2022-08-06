import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

class RequestToServerFailed implements Exception {}

class CSRFTokenParseFailed implements Exception {}

class AccountNotSet implements Exception {}

class NotAuthenticated implements Exception {}

class LogInFailed implements Exception {}

dynamic elemToString(dom.Element element) {
  switch (element.localName) {
    case 'p':
      return element.text.trim();
    case 'ol':
      return element.children.map((e) => e.text.trim());
    case 'div':
      return element.text.trim();
    default:
      return element.text.trim();
  }
}

class EeclassApiClient {
  EeclassApiClient() {
    dio.interceptors.add(CookieManager(cookieJar));
  }
  final String url = 'https://ncueeclass.ncu.edu.tw';
  var dio = Dio();
  var cookieJar = CookieJar();
  var isInitialize = false;
  String? id;
  String? password;

  /// [getCsrfToken] return the current eeclass csrf token in Dio http instance
  /// Usually [CSRFTokenParseFailed] raised is becauce the eeclass page in instance
  /// have already login.
  /// Since we have not implement logout method, when we need to logout just initialize
  /// new [EeclassApiClient] instance, then the Dio http client inside this instance
  /// will have no old session inside to reach the logout purpose.

  Future<String> getCsrfToken() async {
    var response = await dio.get(url);
    if (response.statusCode != 200) {
      throw RequestToServerFailed();
    }
    dom.Document document = htmlparser.parse(response.data.toString());
    List a = document.getElementsByClassName('fs-form-control');
    for (int i = 0; i < a.length; i++) {
      List children = a[i].children;
      for (int j = 0; j < children.length; j++) {
        if (children[j].attributes['name'] == 'csrf-t') {
          return children[j].attributes['value'];
        }
      }
    }
    throw CSRFTokenParseFailed();
  }

  /// The reason why [EeclassApiClient] need to storage user id and password
  /// is because that eeclass backend will kick the session that is not active
  /// for a while.
  //! Complete the comment later (not first priority).

  void setAccount({required String id_, required String password_}) {
    id = id_;
    password = password_;
    isInitialize = true;
  }

  /* Function that used to Login to the eeclass system */

  Future<bool> logIn() async {
    if (!isInitialize) {
      throw AccountNotSet();
    }
    if (await checkLogInStatus()) {
      return true;
    }
    var csrfToken = await getCsrfToken();
    var response = await dio.post(url + '/index/login',
        data: FormData.fromMap({
          '_fmSubmit': 'yes',
          'formVer': '3.0',
          'formId': 'login_form',
          'next': '/',
          'act': 'kick',
          'account': id,
          'password': password,
          'rememberMe': '',
          'csrf-t': csrfToken,
        }));
    if (response.statusCode != 200) {
      id = null;
      password = null;
      throw RequestToServerFailed();
    }
    final loginState = await this.checkLogInStatus();
    if (!loginState) {
      id = null;
      password = null;
      isInitialize = false;
      throw LogInFailed();
    }
    return true;
  }

  Future<bool> checkLogInStatus() async {
    var res = await dio.get(url + '/index/login');
    return res.isRedirect ?? false;
  }

  Future<void> toggleToEng() async {
    if (!await checkLogInStatus()) {
      throw NotAuthenticated();
    }
    var res = await dio.get(url + '/dashboard');
    final resText = res.data.toString();
    final reg =
        RegExp(r'\/ajax\/sys\.app\.service\/changeLocale\/\?ajaxAuth=\w+');
    var ajaxAuth = reg.firstMatch(resText)![0];
    await dio.post(url + ajaxAuth!,
        data: FormData.fromMap({'locale': 'en-us'}));
  }

  Future<List> getCourses({required String semester}) async {
    var loginStat = await checkLogInStatus();
    while (!loginStat) {
      loginStat = await logIn();
    }
    var response =
        await dio.get(url + '/dashboard/historyCourse?termId=' + semester);
    dom.Document document = htmlparser.parse(response.data.toString());
    var target = document.getElementById('myCourseHistoryTable');
    const key = [
      'semester',
      'courseCode',
      'name',
      'professor',
      'credit',
      'grade',
      'classType',
      'courseSerial'
    ];
    var result = <Map<String, String>>[];
    if (target != null) {
      var courseTable =
          target.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
      if (courseTable[0].id == "noData") {
        return [];
      }
      for (var i in courseTable) {
        var value = i.text.split('\n');
        var attr = i.getElementsByTagName('a')[0].attributes;
        value.add(attr['href']!.replaceAll(RegExp(r"/course/"), ""));

        result.add(Map.fromIterables(key, value));
      }
      return result;
    }
    return [];
  }

  /// [getAvalibleSemester] return semester map with
  /// [key : semester name] [value : semester value]
  /// For semester name represent the name of semester like 1101, 1102...etc.
  /// Semester value is a unique id for each semester which will be used when
  /// we need to get courses of specific semester, use function [getCourses]
  /// and passing the semester value in it.
  Future<Map<String, String>> getAvalibleSemester() async {
    var loginStat = await checkLogInStatus();
    while (!loginStat) {
      loginStat = await logIn();
    }
    var response = await dio.get(url + '/dashboard/historyCourse');
    dom.Document document = htmlparser.parse(response.data.toString());
    var target = document.getElementById('termId');
    if (target != null) {
      var result = <String, String>{};
      var semesterList = target.getElementsByTagName('option');
      for (var element in semesterList) {
        var value = element.attributes['value'];
        var semester = element.text.trim();
        if (value != null) {
          result[semester] = value;
        }
      }
      return result;
    } else {
      return <String, String>{};
    }
  }

  Future<Map<String, dynamic>> getCourseInformation(
      {required String courseSerial}) async {
    var loginStat = await checkLogInStatus();
    while (!loginStat) {
      loginStat = await logIn();
    }
    var response = await dio.get(url + '/course/info/' + courseSerial);
    dom.Document document = htmlparser.parse(response.data.toString());
    var info = document.getElementsByClassName(
        'module app-course_info app-course_info-show')[0];
    var infoTitle = info.getElementsByTagName('dt');
    var infoBody = info.getElementsByTagName('dd');
    Map<String, dynamic> result = {};
    for (int i = 0; i < infoTitle.length; i++) {
      switch (infoTitle[i].text.trim()) {
        case 'Code':
          result['classCode'] = infoBody[i].text.trim();
          break;
        case '課程代碼':
          result['classCode'] = infoBody[i].text.trim();
          break;
        case 'Course name':
          result['name'] = infoBody[i].text.trim();
          break;
        case '課程名稱':
          result['name'] = infoBody[i].text.trim();
          break;
        case 'Credits':
          result['credit'] = infoBody[i].text.trim();
          break;
        case '學分':
          result['credit'] = infoBody[i].text.trim();
          break;
        case 'Semester':
          result['semester'] = infoBody[i].text.trim();
          break;
        case '學期':
          result['semester'] = infoBody[i].text.trim();
          break;
        case 'Division':
          result['division'] = infoBody[i].text.trim();
          break;
        case '單位':
          result['division'] = infoBody[i].text.trim();
          break;
        case 'Class':
          result['classes'] = infoBody[i].text.trim();
          break;
        case '班級':
          result['classes'] = infoBody[i].text.trim();
          break;
        case 'Members':
          result['members'] = infoBody[i].text.trim().split(' ')[0];
          break;
        case '修課人數':
          result['members'] = infoBody[i].text.trim().split(' ')[0];
          break;
        case 'Instructor':
          result['instroctors'] = infoBody[i]
              .children
              .map((e) => e.children[1].children[0].children
                  .map((e) => e.text)
                  .toList()
                  .sublist(0, 2))
              .toList();
          break;
        case '老師':
          result['instroctors'] = infoBody[i]
              .children
              .map((e) => e.children[1].children[0].children
                  .map((e) => e.text)
                  .toList()
                  .sublist(0, 2))
              .toList();
          break;
        case 'Teaching assistant':
          result['assistants'] = infoBody[i]
              .children
              .map((e) => e.children[1].children[0].children
                  .map((e) => e.text)
                  .toList()
                  .sublist(0, 2))
              .toList();
          break;
        case '助教':
          result['assistants'] = infoBody[i]
              .children
              .map((e) => e.children[1].children[0].children
                  .map((e) => e.text)
                  .toList()
                  .sublist(0, 2))
              .toList();
          break;
        case 'Description':
          result['description'] = infoBody[i].text;
          break;
        case '課程簡介':
          result['description'] = infoBody[i].text;
          break;
        case 'Syllabus':
          result['syllabus'] = infoBody[i].text;
          break;
        case '課程大綱':
          result['syllabus'] = infoBody[i].text;

          break;
        case 'Textbooks':
          result['textbooks'] = infoBody[i].text;
          break;
        case '教科書':
          result['textbooks'] = infoBody[i].text;
          break;
        case 'Grading description':
          result['gradingDescription'] = infoBody[i].text;
          break;
        case '成績說明':
          result['gradingDescription'] = infoBody[i].text;
          break;
      }
    }
    return result;
  }

  Future<List<Map<String, String?>>> getCourseBulletin(
      {required String courseSerial, required int page}) async {
    var loginStat = await checkLogInStatus();
    while (!loginStat) {
      loginStat = await logIn();
    }
    var response = await dio.get(
        url + '/course/bulletin/' + courseSerial + '?page=' + page.toString());
    dom.Document document = htmlparser.parse(response.data.toString());
    var target = document.getElementById('bulletinMgrTable');

    if (target != null) {
      var bulletins =
          target.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
      if (bulletins[0].id == "noData") {
        return [];
      }
      const key = ['readCount', 'auther', 'date'];
      var result = <Map<String, String?>>[];
      for (var element in bulletins) {
        var value = element
            .getElementsByClassName('hidden-xs')
            .sublist(1)
            .map((e) => e.text);
        var temp = Map<String, String?>.fromIterables(key, value);
        var _info = element.getElementsByTagName('a')[0].attributes;
        temp['title'] = _info['data-modal-title'];
        temp['url'] = _info['data-url'];
        result.add(temp);
      }
      return result;
    }
    return [];
  }

  Future<List<Map<String, String?>>> getCourseMaterial(
      {required String courseSerial}) async {
    var loginStat = await checkLogInStatus();
    while (!loginStat) {
      loginStat = await logIn();
    }
    var response = await dio.get(url + '/course/material/' + courseSerial);
    dom.Document document = htmlparser.parse(response.data.toString());
    var target = document.getElementById('materialListTable');
    if (target != null) {
      var materials =
          target.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
      if (materials[0].id == "noData") {
        return [];
      }
      var result = <Map<String, String?>>[];
      for (var element in materials) {
        var values = element.getElementsByTagName('td');
        Map<String, String?> temp = {};
        for (var i = 0; i < values.length; i++) {
          switch (i) {
            case 1:
              temp['title'] = values[i].text.trim();
              temp['url'] =
                  values[i].getElementsByTagName('a')[0].attributes['href'];
              break;
            case 2:
              temp['auther'] = values[i].text.trim();
              break;
            case 3:
              temp['readCount'] = values[i].text.trim();
              break;
            case 4:
              temp['discussion'] = values[i].text.trim();
              break;
            case 5:
              temp['updateDate'] = values[i].text.trim();
              break;
          }
        }
        result.add(temp);
      }
      return result;
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getCourseAssignment(
      {required String courseSerial}) async {
    var loginStat = await checkLogInStatus();
    while (!loginStat) {
      loginStat = await logIn();
    }
    var response = await dio.get(url + '/course/homeworkList/' + courseSerial);
    dom.Document document = htmlparser.parse(response.data.toString());
    var target = document.getElementById('homeworkListTable');
    if (target != null) {
      var homework =
          target.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
      if (homework[0].id == "noData") {
        return [];
      }
      var result = <Map<String, dynamic>>[];
      for (var element in homework) {
        var values = element.getElementsByTagName('td');
        Map<String, dynamic> temp = {};
        for (var i = 0; i < values.length; i++) {
          switch (i) {
            case 1:
              temp['title'] = values[i].text.trim();
              temp['url'] =
                  values[i].getElementsByTagName('a')[0].attributes['href'];
              break;
            case 2:
              temp['isTeamHomework'] = values[i]
                  .getElementsByClassName('text-overflow')[0]
                  .hasChildNodes();
              break;
            case 3:
              temp['startHandInDate'] = values[i].text.trim();
              break;
            case 4:
              temp['deadline'] = values[i].text.trim();
              break;
            case 5:
              temp['isHandedOn'] = values[i]
                  .getElementsByClassName('text-overflow')[0]
                  .hasChildNodes();
              break;
            case 6:
              temp['score'] = values[i].text.trim();
          }
        }
        result.add(temp);
      }
      return result;
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getCourseQuiz(
      {required String courseSerial}) async {
    var loginStat = await checkLogInStatus();
    while (!loginStat) {
      loginStat = await logIn();
    }
    var response = await dio.get(url + '/course/examList/' + courseSerial);
    dom.Document document = htmlparser.parse(response.data.toString());
    var target = document.getElementById('examListTable');
    if (target != null) {
      var quiz =
          target.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
      if (quiz[0].id == "noData") {
        return [];
      }
      var result = <Map<String, dynamic>>[];
      for (var element in quiz) {
        var values = element.getElementsByTagName('td');
        Map<String, dynamic> temp = {};
        for (var i = 0; i < values.length; i++) {
          switch (i) {
            case 1:
              temp['title'] = values[i].text.trim();
              temp['url'] =
                  values[i].getElementsByTagName('a')[0].attributes['href'];
              break;
            case 2:
              temp['deadLine'] = values[i].text.trim();
              break;
            case 3:
              temp['score'] = values[i].text.trim();
              break;
          }
        }
        result.add(temp);
      }
      return result;
    }
    return [];
  }

  Future<Map<String, dynamic>> getQuiz({required String quizUrl}) async {
    var loginStat = await checkLogInStatus();
    while (!loginStat) {
      loginStat = await logIn();
    }
    var response = await dio.get(url + quizUrl);
    dom.Document document = htmlparser.parse(response.data.toString());
    var target = document
        .getElementsByClassName('fs-page-header-mobile hidden-md hidden-lg');
    Map<String, dynamic> result = {};
    var scoreTag = document.getElementsByClassName('number');
    if (scoreTag.isNotEmpty) {
      result['score'] = double.tryParse(scoreTag[0].text);
    }
    if (target[0].children.length == 2) {
      result['isPaperQuiz'] = true;
    } else {
      result['isPaperQuiz'] = false;
    }
    result['quizTitle'] = target[0].getElementsByTagName('h2')[0].text.trim();
    var quizInfoTable = document.getElementsByClassName('dl-horizontal');
    var infoKeys = quizInfoTable[0].getElementsByTagName("dt");
    var infoValues = quizInfoTable[0].getElementsByTagName("dd");
    result['timeDuration'] = infoValues[0].text.trim();
    result['percentage'] = infoValues[1].text.trim();
    result['fullMarks'] = double.tryParse(infoValues[2].text.trim());
    result['passingMarks'] = double.tryParse(infoValues[3].text.trim());
    if (infoKeys[4].text.trim() == "Duration" ||
        infoKeys[4].text.trim() == "時間限制") {
      result['timeLimit'] = infoValues[4].text.trim();
    }
    result['discription'] =
        infoValues[5].text.trim().replaceAll(RegExp(r'\n\n'), "\n");
    var tooltable = document.getElementsByClassName("fs-tools");
    if (tooltable.isNotEmpty) {
      for (var element in tooltable[0].getElementsByTagName("a")) {
        if (element.text == "") {
          continue;
        } else {
          switch (element.text) {
            case "成績分布":
              result['scoreDistributionUrl'] = element.attributes['href'];
              result['scoreDistribution'] = await getQuizScoreDistribution(
                  scoreDistributionUrl: result['scoreDistributionUrl']);
              break;
            case "作答記錄":
              result['quizRecordUrl'] = element.attributes['href'];
              break;
            case "檢視解答":
              result['answerUrl'] = element.attributes['href'];
              break;

            default:
              continue;
          }
        }
      }
    }
    print(result);
    return result;
  }

  Future<List<int>> getQuizScoreDistribution(
      {required String scoreDistributionUrl}) async {
    var loginStat = await checkLogInStatus();
    while (!loginStat) {
      loginStat = await logIn();
    }
    var response = await dio.get(url + scoreDistributionUrl);
    dom.Document document = htmlparser.parse(response.data.toString());
    var target = document.getElementById("exam_paper_statistics");
    var infoTags = target!
        .getElementsByTagName("tbody")[0]
        .getElementsByClassName(" text-center  col-char2");
    var result = <int>[];
    for (int i = infoTags.length - 1; i >= 0; i--) {
      result.add(int.parse(infoTags[i].text));
    }
    return result;
  }
}
