import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'get_from_web.dart';

import '../model/src_api.dart';
import '../model/asset.dart';
import '../utils/const.dart';

class WebSocketSrc implements SrcApi {

  IOWebSocketChannel _channel;

  @override
  Future<List<Asset>> getAssets() async {
    List<Asset> assets = [];
    String jsonString = await GetFromWeb.getJsonWeb(kUrlAssests);
    for (var a in json.decode(jsonString)) {
      assets.add(Asset.fromJson(a));
    }
    return assets;
  }

  @override
  bool start(String symbol, OnData onData, {OnError onError}) {
    bool res = false;
    print("* websocket.start");
    try {
      _channel = IOWebSocketChannel.connect(Uri.parse("$kWsUrlQuotes?token=$kWsToken"));
      _channel.stream.listen(onData, cancelOnError: true, onError: onError, onDone: _onDone);
      //_channel.stream.listen(_testData, cancelOnError: false, onError: _onError, onDone: _onDone);
      print("* websocket.listen");

      const _request = kWsExampleFirstQuery;
      _channel.sink.add(_request);

      print("* websocket.sink.add($_request)");
      res = true;
    } catch (e) {
      print("* websocket.catch error: ${e.toString()}");
    }
    return res;
  }

  // void _testData(dynamic msg) => print("* websocket.onData: ${msg.toString()}");
  // void _onError(Object error) => print("* websocket._onError: $error");
  void _onDone() => print("* websocket._onDone");

  @override
  void stop() {
    print("* websocket.stop");
    _channel.sink.close(status.goingAway);
  }

}

