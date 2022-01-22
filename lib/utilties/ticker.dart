class Ticker {
  const Ticker();
  Stream<int> tick(int duration) {
    return Stream.periodic(Duration(seconds: duration), (x) => x);
  }
}
