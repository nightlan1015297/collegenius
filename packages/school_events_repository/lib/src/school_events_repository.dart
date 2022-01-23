import 'dart:async';
import 'package:school_events_api/school_events_api.dart';

class SchoolEventslFailure implements Exception {}

class SchoolEventsRepository {
  SchoolEventsRepository() : _schoolEventsApiClient = SchoolEventApiClient();
  final SchoolEventApiClient _schoolEventsApiClient;

  Future<List<Map<String, dynamic>>> getEvents(int page) async {
    final _event = await _schoolEventsApiClient.getEvents(page);
    return _event;
  }
}
