import 'package:course_select_api/course_select_api.dart';
import 'package:eeclass_api/eeclass_api.dart';

enum Server { eeclass, courseSelect }

class AuthenticationRepository {
  final CourseSelectApiClient _courseSelectApiClient = CourseSelectApiClient();
  final EeclassApiClient _eeclassApiClient = EeclassApiClient();

  Future<Map<Server, bool>> authFromMultipleServer(
      {required String id, required String password}) async {
    var result = {Server.eeclass: false, Server.courseSelect: false};
    try {
      _courseSelectApiClient.setAccount(id_: id, password_: password);
      await _courseSelectApiClient.logIn();
      if (await _courseSelectApiClient.checkLogInStatus()) {
        result[Server.courseSelect] = true;
      }
      _eeclassApiClient.setAccount(id_: id, password_: password);
      await _eeclassApiClient.logIn();
      if (await _eeclassApiClient.checkLogInStatus()) {
        result[Server.eeclass] = true;
      }
      return result;
    } catch (e) {
      print(e);
      return result;
    }
  }
}
