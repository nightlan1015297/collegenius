import 'package:dio/dio.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;
import 'models/models.dart';

class RequestToServerFailed implements Exception {}

class IndexOutOfRange implements Exception {}

class SchoolInformationApiClient {
  final String url = 'https://www.ncu.edu.tw/tw/events/index.php';
  var dio = Dio();

  Future<List<Event>> getEvents(int page) async {
    final requestUrl = url + '?page=' + page.toString();
    var response = await dio.get(requestUrl);
    if (response.statusCode != 200) {
      throw RequestToServerFailed();
    }
    dom.Document document = htmlparser.parse(response.data.toString());
    var events = document.getElementsByClassName('eventlist');
    var result = <Event>[];
    for (var element in events) {
      var _node = element.children[0];

      var categoryNode = _node.getElementsByClassName('tabconstr')[0];
      var groupNode = _node.getElementsByClassName('tabDept')[0];
      var dateNode = _node.getElementsByClassName('event-date')[0];
      var information = Map<String, dynamic>();
      information['title'] = _node.attributes['title'];
      information['href'] = _node.attributes['href'];
      information['category'] = categoryNode.text;
      information['group'] = groupNode.text;
      information['time'] = dateNode.children[0].text;
      result.add(Event.fromJson(information));
    }

    return result;
  }
}
