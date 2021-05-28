// Источники данных для графиков
enum DataType {quote, ohlc}

abstract class SrcApi {

  // initializing
  Future<bool> iniSrc() { }

  Future<void> start(DataType type) {}

  Stream<dynamic> getData(DataType type) {}

  void stop(DataType type) {}
}