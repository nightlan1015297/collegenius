part of 'school_events_cubit.dart';

enum SchoolEventsStatus { initial, loading, loadedend, success, failure }

extension SchoolEventsStatusX on SchoolEventsStatus {
  bool get isInitial => this == SchoolEventsStatus.initial;
  bool get isLoading => this == SchoolEventsStatus.loading;
  bool get isLoadmore => this == SchoolEventsStatus.loadedend;
  bool get isSuccess => this == SchoolEventsStatus.success;
  bool get isFailure => this == SchoolEventsStatus.failure;
}

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
