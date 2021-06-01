import 'dart:convert';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../model/src_api.dart';
import '../model/asset.dart';
import '../utils/const.dart';

class WebSocketSrc implements SrcApi {

  List<Asset> assets = [];
  static final Utf8Decoder _utf8decoder = Utf8Decoder();

  IOWebSocketChannel _channel;

  @override
  Future<String> getAssets() async {
    String error = "";
    String url = kWsUrlDoc;
    var req;
    Client client = Client();
    Map<String, String> userHeader = {"Authorization": "Bearer $kWsToken", "Content-Type": "application/json"};
    if(assets.length > 0) {
      assets.clear();
    }
    try {
      print("* getFromWeb.try: ${url}");
      req = await client.get(Uri.parse(url), headers: userHeader);
      print("* statuc Code: ${req.statusCode}");
      if (req.statusCode == 200) {
        String jsonString = _utf8decoder.convert(req.bodyBytes);
        for (var a in json.decode(jsonString)) {
          assets.add(Asset.fromJson(a));
        }
        print("* assets.length=${assets.length}");
      } else {
        error = "Error retrieving catalog from internet" + ": code=" + req.statusCode.toString();
      }
    } catch (e) {
      error = "Error retrieving catalog from internet" + ": " + e.toString();
    }
    if (client != null) {
      client.close();
    }
    // print("${utf8decoder.convert(req.bodyBytes) ?? ""}");
    return error;
  }

  @override
  bool start(String symbol, OnData onData, {OnError onError}) {
    bool res = false;
    print("* websocket.start");
    try {
      _channel = IOWebSocketChannel.connect(Uri.parse("${kWsUrl}?token=$kWsToken"));
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
    _channel?.sink.close(status.goingAway);
  }

}

