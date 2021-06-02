// Источники данных для графиков

import 'asset.dart';

typedef OnData = void Function(dynamic a);
typedef OnError = void Function(Object error);

abstract class SrcApi {

  Future<List<Asset>> getAssets();

  // start receiving data
  bool start(String symbol, OnData onData, {OnError onError});

  // stop receiving data
  void stop();

  }