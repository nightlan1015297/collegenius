class TimeStream {
  const TimeStream();

  Stream<DateTime> start() {
    return Stream.periodic(Duration(seconds: 1), (x) => DateTime.now());
  }
}
