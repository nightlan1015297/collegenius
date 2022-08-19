part of 'school_events_cubit.dart';

class SchoolEventsState extends Equatable {
  SchoolEventsState({
    this.status = SchoolEventsStatus.initial,
    List<SchoolEvent>? events,
    int? loadedPage,
  })  : loadedPage = loadedPage ?? 1,
        events = events ?? [];

  final SchoolEventsStatus status;
  final int loadedPage;
  final List<SchoolEvent> events;

  SchoolEventsState copyWith(
      {SchoolEventsStatus? status,
      int? loadedPage,
      List<SchoolEvent>? events}) {
    return SchoolEventsState(
        status: status ?? this.status,
        loadedPage: loadedPage ?? this.loadedPage,
        events: events ?? this.events);
  }

  @override
  List<Object> get props => [status, loadedPage, events];
}
