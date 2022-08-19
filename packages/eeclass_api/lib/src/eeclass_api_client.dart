import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;

class LoadPageFailed implements Exception {
  LoadPageFailed(this.description);
  final String description;
  @override
  String toString() {
    return "'LoadPageFailed' instance \n$description";
  }
}

class CSRFTokenParseFailed implements Exception {
  CSRFTokenParseFailed(this.description);
  final String description;
  @override
  String toString() {
    super.toString();
    return "'CSRFTokenParseFailed' instance \n$description";
  }
}

class AccountNotSet implements Exception {
  AccountNotSet(this.description);
  final String description;
  @override
  String toString() {
    return "'AccountNotSet' instance \n$description";
  }
}

class NotAuthenticated implements Exception {
  NotAuthenticated(this.description);
  final String description;
  @override
  String toString() {
    return "'NotAuthenticated' instance \n$description";
  }
}

class LogInFailed implements Exception {
  LogInFailed(this.description);
  final String description;
  @override
  String toString() {
    return "'LogInFailed' instance \n$description";
  }
}

class EeclassApiClient {
  EeclassApiClient() {
    dio.interceptors.add(CookieManager(cookieJar));
  }
  static String url = 'https://ncueeclass.ncu.edu.tw';
  static BaseOptions options = new BaseOptions(
    baseUrl: url,
    receiveDataWhenStatusError: true,
    connectTimeout: 60 * 1000, // 60 seconds
    receiveTimeout: 60 * 1000, // 60 seconds
    headers: {
      'user-agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36',
    },
  );

  var dio = Dio(options);
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
    var response = await dio.get('');
    if (response.statusCode != 200) {
      throw LoadPageFailed(
        '''Http server response a bad status code ${response.statusCode},
          when get csrf token.
          Following is the response body:
          response status code: ${response.statusCode}
          response statusMessage: ${response.statusMessage},
          response data: ${response.data}
          ''',
      );
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
    throw CSRFTokenParseFailed(
      '''Cannot find csrf token in the eeclass page.
    This happens when the eeclass page has already login, but still trying to get 
    CSRF token from the page.
    Try add [checkLogInStatus] at the beginning of the [logIn] method.
    ''',
    );
  }

  /// The reason why [EeclassApiClient] need to storage user id and password
  /// is because that eeclass backend will kick the session that is not active
  /// for a while.
  /// So we can not determine whenever we need to login again, the best practice
  /// is to [checkLogInStatus] in each time we need to access Eeclass system's
  /// resource.
  /// It will reduce readibility if we implement logic above in business logic layer
  /// thus we implement it in Api layer.Storage user information inside instance,
  /// makes user data is accessable at everytime Api needs to login.

  Future<bool> setAccountAndValidate({
    required String id_,
    required String password_,
  }) async {
    id = id_;
    password = password_;
    isInitialize = true;
    final validationResult = await logIn();
    return validationResult;
  }

  /// [logIn] function is used to let dio instance to log in eeclass system
  /// If [logIn] function returns, it will always be true.
  /// If login failed the function will raise different error based on
  /// different type of login error was cast.
  /// The most common login error [LogInFailed] will raised for following reason :
  /// -> The whole [login] proccess was done (the post method has post the login formdata
  /// and get the response) but [checkLogInStatus] still returns that the dio instance was
  /// not login.
  /// It may happens because of the wrong password or student id
  /// or Eeclass system's some mechanism block the login proccess
  /// If you find out that you did not enter wrong id & password, but the Api keep
  /// raise [LogInFailed] error, un comment the printHighlight function to check what
  /// Eeclass system prompt.

  Future<bool> logIn() async {
    if (!isInitialize) {
      throw AccountNotSet(
        '''Account was not set when calling logIn method, 
        EeclassApiClient instance storage user information inside instance,
        Thus when initializing new EeclassApiClient instance, the user information
        will need to be set.
        Insure you have called [setAccount] method once before calling [logIn] method.
        ''',
      );
    }
    if (await checkLogInStatus()) {
      return true;
    }
    var csrfToken = await getCsrfToken();
    var response = await dio.post('/index/login',
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
      isInitialize = false;
      throw LoadPageFailed(
        '''Http server response a bad status code ${response.statusCode},
          when post login data.
          Following is the response body:
          response status code: ${response.statusCode}
          response statusMessage: ${response.statusMessage},
          response data: ${response.data}
          ''',
      );
    }

    ///printHighlight(response.data);
    final loginState = await this.checkLogInStatus();
    if (!loginState) {
      id = null;
      password = null;
      isInitialize = false;
      throw LogInFailed(
        '''
          This is usually cause by the popup window has prompted by Eeclass system:
          It may happens when:
          1. The wrong password or student id.
          2. Eeclass system trying to ask user to kick device that has already login.

          Usually second reason is not mostly the reason, because the login data has 
          specified 'act': 'kick', which will kich the device that has already login.
          
          This error can simply interpret to wrong password or student id.
          ''',
      );
    }
    return true;
  }

  /// [checkLogInStatus] function is used to check if the
  /// dio instance is login to eeclass or not.
  /// Using the feature that the eeclass will redirect to the dashboard if the
  /// user has already log in but still want to access login page
  /// Thus is redirect or not can be used to let us know if the user has already login.
  Future<bool> checkLogInStatus() async {
    var res = await dio.get('/index/login');
    return res.isRedirect ?? false;
  }

  Future<void> readyToFetch() async {
    final status = await checkLogInStatus();
    if (!status) {
      await logIn();
    }
  }

  Future<List<Cookie>> cookies() async {
    await readyToFetch();
    return await cookieJar
        .loadForRequest(Uri.https('ncueeclass.ncu.edu.tw', ''));
  }

  Future<void> toggleToEng() async {
    await readyToFetch();

    var res = await dio.get('/dashboard');
    final resText = res.data.toString();
    final reg =
        RegExp(r'\/ajax\/sys\.app\.service\/changeLocale\/\?ajaxAuth=\w+');
    var ajaxAuth = reg.firstMatch(resText)![0];
    await dio.post(ajaxAuth!, data: FormData.fromMap({'locale': 'en-us'}));
  }

  Future<List> getCourses({
    required String semester,
  }) async {
    await readyToFetch();

    var response = await dio.get('/dashboard/historyCourse?termId=' + semester);
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
    await readyToFetch();

    var response = await dio.get('/dashboard/historyCourse');
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

  Future<Map<String, dynamic>> getCourseInformation({
    required String courseSerial,
  }) async {
    await readyToFetch();

    var response = await dio.get('/course/info/' + courseSerial);
    dom.Document document = htmlparser.parse(response.data.toString());
    var info = document
        .getElementsByClassName('module app-course_info app-course_info-show');

    /// Early return if the course data is not avaliable.
    if (info.isEmpty) {
      return <String, dynamic>{};
    }

    var infoTitle = info[0].getElementsByTagName('dt');
    var infoBody = info[0].getElementsByTagName('dd');
    Map<String, dynamic> result = {};
    for (int i = 0; i < infoTitle.length; i++) {
      switch (infoTitle[i].text.trim()) {
        case 'Code':
        case '課程代碼':
          result['classCode'] = infoBody[i].text.trim();
          break;
        case 'Course name':
        case '課程名稱':
          result['name'] = infoBody[i].text.trim();
          break;
        case 'Credits':
        case '學分':
          result['credit'] = infoBody[i].text.trim();
          break;
        case 'Semester':
        case '學期':
          result['semester'] = infoBody[i].text.trim();
          break;
        case 'Division':
        case '單位':
          result['division'] = infoBody[i].text.trim();
          break;
        case 'Class':
        case '班級':
          result['classes'] = infoBody[i].text.trim();
          break;
        case 'Members':
        case '修課人數':
          result['members'] = infoBody[i].text.trim().split(' ')[0];
          break;
        case 'Instructor':
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
        case '課程簡介':
          result['description'] = infoBody[i].text;
          break;
        case 'Syllabus':
        case '課程大綱':
          result['syllabus'] = infoBody[i].text;
          break;
        case 'Textbooks':
        case '教科書':
          result['textbooks'] = infoBody[i].text;
          break;
        case 'Grading description':
        case '成績說明':
          result['gradingDescription'] = infoBody[i].text;
          break;
      }
    }
    return result;
  }

  Future<List<Map<String, String?>>> getCourseBulletin({
    required String courseSerial,
    required int page,
  }) async {
    await readyToFetch();

    var response = await dio
        .get('/course/bulletin/' + courseSerial + '?page=' + page.toString());
    dom.Document document = htmlparser.parse(response.data.toString());
    var target = document.getElementById('bulletinMgrTable');

    if (target != null) {
      var bulletins =
          target.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
      if (bulletins[0].id == "noData") {
        return [];
      }
      const key = [
        'readCount',
        'auther',
        'date',
      ];
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

  Future<Map<String, dynamic>> getBullitin({
    required String bullitinUrl,
  }) async {
    await readyToFetch();

    var response = await dio.get(bullitinUrl);
    dom.Document document = htmlparser.parse(response.data.toString());
    var result = <String, dynamic>{};
    var textContentList = [];
    var textContent =
        document.getElementsByClassName('fs-text-break-word bulletin-content');
    if (textContent.isNotEmpty) {
      for (var element in textContent[0].children) {
        textContentList.add(element.text);
      }
    }
    result['content'] = textContentList;
    var fileContent = document.getElementsByClassName('fs-list fs-filelist ');
    var fileContentList = [];
    if (fileContent.isNotEmpty) {
      for (var element in fileContent[0].getElementsByTagName('a')) {
        fileContentList.add([
          element.text,
          element.attributes['href'],
        ]);
      }
    }
    result['fileList'] = fileContentList;
    return result;
  }

  Future<List<Map<String, dynamic>>> getCourseMaterial({
    required String courseSerial,
  }) async {
    await readyToFetch();

    var response = await dio.get('/course/material/' + courseSerial);
    dom.Document document = htmlparser.parse(response.data.toString());
    var target = document.getElementById('materialListTable');
    if (target != null) {
      var materials =
          target.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
      if (materials[0].id == "noData") {
        return [];
      }
      var result = <Map<String, dynamic>>[];
      for (var element in materials.sublist(1)) {
        var values = element.getElementsByTagName('td');
        Map<String, dynamic> temp = {};
        for (var i = 0; i < values.length; i++) {
          switch (i) {
            case 1:
              temp['title'] = values[i]
                  .text
                  .trim()
                  .replaceAll(RegExp(r'\n'), "")
                  .replaceAll(RegExp(r'( )\1+'), " ");

              temp['url'] =
                  values[i].getElementsByTagName('a')[0].attributes['href'];
              switch (values[i]
                  .getElementsByClassName("fs-iconfont")[0]
                  .className) {
                case "fs-iconfont far fa-file-alt":
                  temp['type'] = "attachment";
                  break;
                case "fs-iconfont far fa-file-pdf":
                  temp['type'] = "pdf";
                  break;
                case "fs-iconfont fab fa-youtube":
                  temp['type'] = "youtube";
                  break;
                case "fs-iconfont fal fa-file-audio":
                  temp['type'] = "audio";
                  break;
                default:
                  temp['type'] = "unknown";
              }

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

  Future<Map<String, dynamic>> getMaterial({
    required String type,
    required String materialUrl,
  }) async {
    await readyToFetch();

    var response = await dio.get(materialUrl);
    dom.Document document = htmlparser.parse(response.data.toString());
    Map<String, dynamic> result = {};
    switch (type) {
      case "attachment":
        var description =
            document.getElementsByClassName("fs-block-body list-margin");
        if (description[0].children.isNotEmpty) {
          result['description'] = description[0].text.trim();
        }
        final fileSection =
            document.getElementsByClassName("fs-list fs-filelist ");
        if (fileSection.isNotEmpty) {
          var fileList = [];
          final fileListTag = fileSection[0].getElementsByTagName("a");
          for (var element in fileListTag) {
            fileList.add([element.text, element.attributes['href']]);
          }
          result['fileList'] = fileList;
        } else {
          result['fileList'] = [];
        }
        return result;
      case "youtube":
        var sourceTag = document
            .getElementById("info-tabs-detail")!
            .getElementsByTagName("dd")[4];
        var source = sourceTag.getElementsByTagName("a")[0].attributes['href'];
        result['source'] = source;
        return result;
      case "audio":
        return result;
      case "unknown":
        return result;
      case "pdf":
        var source = document
            .getElementsByClassName("btn  mobile-only btn-primary")[0]
            .attributes['href'];
        result['source'] = source;
        return result;
      default:
        return result;
    }
  }

  Future<List<Map<String, dynamic>>> getCourseAssignment({
    required String courseSerial,
  }) async {
    await readyToFetch();

    var response = await dio.get('/course/homeworkList/' + courseSerial);
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
        for (var i = 1; i < values.length; i++) {
          switch (i) {
            case 1:
              temp['title'] =
                  values[i].text.trim().replaceAll(RegExp(r'\n'), "");
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
              temp['score'] = double.tryParse(values[i].text.trim());
          }
        }
        result.add(temp);
      }
      return result;
    }
    return [];
  }

  Future<Map<String, dynamic>> getAssignment({
    required String assignmentUrl,
  }) async {
    await readyToFetch();

    var response = await dio.get(assignmentUrl);
    dom.Document document = htmlparser.parse(response.data.toString());
    final informationTable =
        document.getElementsByClassName("dl-horizontal ")[0];
    final infoTitle = informationTable.getElementsByTagName('dt');
    final infoBody = informationTable.getElementsByTagName('dd');
    Map<String, dynamic> result = {};
    for (int i = 0; i < infoTitle.length; i++) {
      switch (infoTitle[i].text.trim()) {
        case 'Start Time':
        case '開放繳交':
          result['allowUploadDate'] = infoBody[i].text.trim();
          break;
        case 'Submitted':
        case '已繳交':
          result['hasUploadedPeople'] = infoBody[i].text.trim();
          break;
        case 'End Time':
        case '繳交期限':
          result['deadline'] = infoBody[i].text.trim();
          break;
        case 'Allow late submission':
        case '允許遲交':
          if (infoBody[i].text.trim() == '是' ||
              infoBody[i].text.trim() == 'Yes') {
            result['canDelay'] = true;
          } else {
            result['canDelay'] = false;
          }
          break;
        case 'Percentage':
        case '成績比重':
          result['percentage'] = infoBody[i].text.trim();
          break;
        case 'Grading method':
        case '評分方式':
          result['gradingMethod'] = infoBody[i].text.trim();
          break;
        case 'Description':
        case '說明':
          result['description'] = infoBody[i].text.trim();
          break;
        case 'Attachment(s)':
        case '附件':
          var fileListTag = infoBody[i].getElementsByTagName("a");
          var fileList = [];
          for (var element in fileListTag) {
            fileList.add([element.text, element.attributes['href']]);
          }
          result['fileList'] = fileList;
          break;
      }
    }
    return result;
  }

  Future<List<Map<String, dynamic>>> getCourseQuiz({
    required String courseSerial,
  }) async {
    await readyToFetch();

    var response = await dio.get('/course/examList/' + courseSerial);
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
              temp['score'] = double.tryParse(values[i].text.trim());
              break;
          }
        }
        result.add(temp);
      }
      return result;
    }
    return [];
  }

  Future<Map<String, dynamic>> getQuiz({
    required String quizUrl,
  }) async {
    await readyToFetch();

    var response = await dio.get(quizUrl);
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
    var description = '';
    var attachments = [];
    for (var element in infoValues[5].children) {
      if (element.className == "fs-list fs-filelist ") {
        for (var attachmentTag in element.getElementsByTagName("a")) {
          attachments
              .add([attachmentTag.text, attachmentTag.attributes['href']]);
        }
      } else {
        description += element.text;
        description += "\n";
      }
    }
    result['description'] = description.trim();
    result['attachments'] = attachments;

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
    return result;
  }

  Future<List<int>> getQuizScoreDistribution({
    required String scoreDistributionUrl,
  }) async {
    await readyToFetch();

    var response = await dio.get(scoreDistributionUrl);
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
