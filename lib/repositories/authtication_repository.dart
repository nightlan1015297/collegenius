import 'package:course_select_api/course_select_api.dart';

class AuthenticationRepository {
  final CourseSelectApiClient _courseSelectApiClient = CourseSelectApiClient();

  Future<void> authFromMultipleServer(
      {required String id, required String password}) async {
    try {
      _courseSelectApiClient.setAccount(id_: id, password_: password);
      await _courseSelectApiClient.logIn();
    } catch (e) {
      print(e);
      return;
    }
  }
}
