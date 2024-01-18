import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:path_provider/path_provider.dart';

class LoadPageFailed implements Exception {
  LoadPageFailed(this.description);
  final String description;
}

class CSRFTokenParseFailed implements Exception {
  CSRFTokenParseFailed(this.description);
  final String description;
}

class AccountNotSet implements Exception {
  AccountNotSet(this.description);
  final String description;
}

class DioInstanceNotInitialize implements Exception {
  DioInstanceNotInitialize(this.description);
  final String description;
}

class NotAuthenticated implements Exception {
  NotAuthenticated(this.description);
  final String description;
}

class LogInFailed implements Exception {
  LogInFailed(this.description);
  final String description;

  @override
  String toString() {
    return "'LogInFailed' instance \n$description";
  }
}

class NeedCaptcha implements Exception {
  NeedCaptcha(this.description);
  final String description;
}

class GetCsfrTokenFailed implements Exception {
  GetCsfrTokenFailed(this.description);
  final String description;
}

class PortalApiClient {
  static String baseUrl = 'https://portal.ncu.edu.tw';
  static BaseOptions options = BaseOptions(
    baseUrl: baseUrl,
    receiveDataWhenStatusError: true,
    connectTimeout: 60 * 1000, // 60 seconds
    receiveTimeout: 60 * 1000, // 60 seconds
    headers: {
      'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.81 Safari/537.36 Edg/104.0.1293.47',
    },
  );
  late PersistCookieJar _cookieJar;
  late CookieManager _cookieManager;

  var dio = Dio(options);
  var isDioInitialize = false;
  var isAccountInitialize = false;
  String? id;
  String? password;

  Future<PersistCookieJar> get cookieJar async {
    Directory appDocDir = await getApplicationSupportDirectory();
    String appDocPath = appDocDir.path;
    _cookieJar = PersistCookieJar(storage: FileStorage('$appDocPath/cookie'));
    return _cookieJar;
  }

  Future<void> initializeDio() async {
    if (!isDioInitialize) {
      _cookieJar = await cookieJar;
      _cookieManager = CookieManager(_cookieJar);
      dio.interceptors.add(_cookieManager);
      isDioInitialize = true;
    }
  }

  Future<bool> setAccountAndValidate({
    required String id_,
    required String password_,
  }) async {
    if (!isAccountInitialize) {
      id = id_;
      password = password_;
      isAccountInitialize = true;
    }
    return await login();
  }

  Future<void> fetchCookie() async {
    await dio.get('/login',
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  Future<bool> checkLoginStatus() async {
    if (!isDioInitialize) {
      throw DioInstanceNotInitialize('Dio instance not initialize');
    }
    await fetchCookie();
    var res = await dio.get('/login');
    if (res.isRedirect == null) {
      return false;
    } else {
      return res.isRedirect!;
    }
  }

  Future<void> setCookie(
      {required String cookieKey, required String cookieValue}) async {
    await _cookieManager.cookieJar.saveFromResponse(Uri.parse(baseUrl), [
      Cookie(
        cookieKey,
        cookieValue,
      )
    ]);
  }

  Future<bool> needCaptcha() async {
    await fetchCookie();
    var res = await dio.get('');
    var html = htmlparser.parse(res.data);
    var captcha = html.getElementsByClassName('g-recaptcha');
    if (captcha.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getCsfrToken() async {
    await dio.get('');
    final cookies = await _cookieJar.loadForRequest(Uri.parse(baseUrl));
    for (var cookie in cookies) {
      if (cookie.name == 'XSRF-TOKEN') {
        return cookie.value;
      }
    }
    throw GetCsfrTokenFailed('Cannot get CSRF-TOKEN');
  }

  Future<bool> login() async {
    if (!isDioInitialize) {
      throw DioInstanceNotInitialize('Dio instance not initialize');
    }
    if (!isAccountInitialize) {
      throw AccountNotSet(
        '''Account was not set when calling logIn method, 
        EeclassApiClient instance storage user information inside instance,
        Thus when initializing new EeclassApiClient instance, the user information
        will need to be set.
        Insure you have called [setAccount] method once before calling [logIn] method.
        ''',
      );
    }
    if (await checkLoginStatus()) {
      return true;
    }
    if (await needCaptcha()) {
      throw NeedCaptcha(
          '''The session in this dio instance did not pass catpcha check''');
    }
    final csrf = await getCsfrToken();
    var response = await dio.post(
      '/login',
      data: FormData.fromMap(
        {
          'language': 'CHINESE',
          'username': id,
          'password': password,
          '_csrf': csrf,
        },
      ),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return true;
        },
      ),
    );
    if (!await checkLoginStatus()) {
      id = null;
      password = null;
      isAccountInitialize = false;
      throw LogInFailed(
        '''
          This error is raised because the Portal system is not login after execute
          all login proccess.
          The mostly problem to cause this error is the wrong user information
          (wrong student id or password.)
          
          Try to correct your id and password and Manual login again.
        ''',
      );
    }
    return true;
  }

  Future<void> readyToFetch() async {
    if (!await checkLoginStatus()) {
      await login();
    }
    return;
  }

  Future<String> getToken() async {
    final response = await dio.get('');
    final data = response.data.toString();
    final RegExp exp = RegExp(r'var token = "(.*?)";');
    final result = exp.firstMatch(data);
    return result![1]!;
  }

  Future<bool> logout() async {
    if (!isDioInitialize) {
      throw DioInstanceNotInitialize('Dio instance not initialize');
    }
    if (isAccountInitialize) {
      final response = await dio.get('/logout');
    }
    if (await checkLoginStatus()) {
      return false;
    } else {
      isAccountInitialize = false;
      id = null;
      password = null;
      return true;
    }
  }
}
