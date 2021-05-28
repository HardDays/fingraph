// Источники данных для графиков

import 'asset.dart';

enum DataType {quote, ohlc}

typedef OnData = void Function(dynamic a);
typedef OnError = void Function(Object error);

abstract class SrcApi {
  List<Asset> assets;

  // start receiving data
  bool start(String symbol, DataType type, OnData onData, {OnError onError}) { }

  // stop receiving data
  void stop() {}

  Future<String> getAssets() async {}
}