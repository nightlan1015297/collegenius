import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:portal_api/portal_api.dart';

class PortalRepository {
  PortalApiClient _portalApiClient = PortalApiClient();
  String? username;
  String? password;

  void logout() {
    _portalApiClient.logout();
    username = null;
    password = null;
  }

  /// Portal Api Client uses persistent cookies to keep the Google Recaptcha session
  /// Thus to prevent user keep doing captcha every time they login, we need to
  /// initialize the persistent cookie jar before doing anything.
  Future<void> initializeDio() async {
    await _portalApiClient.initializeDio();
  }

  void setCookie({required Cookie cookie}) {
    _portalApiClient.setCookie(
      cookieKey: cookie.name,
      cookieValue: cookie.value,
    );
  }

  Future<bool> needCaptcha() async {
    final didNeedCaptcha = await _portalApiClient.needCaptcha();
    return didNeedCaptcha;
  }

  Future<bool> login(
      {required String username_, required String password_}) async {
    if (username == username_ && password == password_) {
      return true;
    }
    final isLogIn = await _portalApiClient.setAccountAndValidate(
        id_: username_, password_: password_);
    if (isLogIn) {
      username = username_;
      password = password_;
    }
    return isLogIn;
  }
}
