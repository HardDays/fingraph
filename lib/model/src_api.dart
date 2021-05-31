// Источники данных для графиков

import 'asset.dart';

enum DataType {quote, ohlc}

typedef OnData = void Function(dynamic a);
typedef OnError = void Function(Object error);

abstract class SrcApi {
  List<Asset> assets;

  Future<String> getAssets() async {}

  // start receiving data
  bool start(String symbol, OnData onData, {OnError onError}) { }

  // stop receiving data
  void stop() {}
}