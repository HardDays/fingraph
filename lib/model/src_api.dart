// Источники данных для графиков
import 'package:fingraph/model/request_args.dart';

import 'asset.dart';

typedef OnData = void Function(dynamic a);
typedef OnError = void Function(Object error);

abstract class SrcApi {
  set requestArgs(RequestArgs requestArgs);
  RequestArgs get requestArgs;

  Future<List<Asset>> getAssets();

  Future<List<dynamic>> getHistory(RequestArgs ra);

  // start receiving data
  bool start(String symbol, OnData onData, {OnError onError});

  // stop receiving data
  void stop();

  }