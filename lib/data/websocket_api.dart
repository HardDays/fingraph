import 'dart:convert';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../model/src_api.dart';
import '../model/asset.dart';
import '../utils/const.dart';

/* Notes:
  // Content-Type: application/json
  // Authorization: Bearer <TOKEN>

  // Все передаваемые данные — простые записи, сериализованные в JSON[3].
  // Запрос — вызов определённого метода, предоставляемого удалённой системой.
  // Он должен содержать три обязательных свойства:
  // - method — строка с именем вызываемого метода.
  // - params — массив данных, которые должны быть переданы методу, как параметры.
  // - id — значение любого типа, которое используется для установки соответствия
  //   между запросом и ответом.

  // {"jsonrpc":"2.0","method":"subscribe","params":[{"channels":["tick.aud_usd_afx"]}]}

  // Сервер должен отослать правильный ответ на каждый полученный запрос.
  // Ответ должен содержать следующие свойства:
  // - result — данные, которые вернул метод. Если произошла ошибка во время выполнения метода,
  //   это свойство должно быть установлено в null.
  // - error — код ошибки, если произошла ошибка во время выполнения метода, иначе null.
  // - id — то же значение, что и в запросе, к которому относится данный ответ.

  final channel = IOWebSocketChannel.connect('ws://localhost:1234');
  channel.stream.listen((message) {
    channel.sink.add('received!');
    channel.sink.close(status.goingAway);
  });
*/

class WebSocketSrc implements SrcApi {

  List<Asset> assets = [];
  static final Utf8Decoder _utf8decoder = Utf8Decoder();

  IOWebSocketChannel _channel;

  // List<Quote> quoteList;
  // List<Ohlc> ohlsList;

  @override
  bool start(String symbol, DataType type, OnData onData, {OnError onError}) {
    try {
      _channel = IOWebSocketChannel.connect("${kWsUrl}?token=${kWsToken}");
      _channel.stream.listen((event) => onData, cancelOnError: true, onError: (e)=> print("**error: $e"));
      const _request = '{"jsonrpc":"2.0","method":"subscribe","params":[{"channels":["tick.aud_usd_afx"]}]}';
      _channel.sink.add(_request);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void onError(Object error) {
    print("* Error: $error");
  }

  @override
  void stop() {
    _channel?.sink.close(status.goingAway);
  }

  @override
  Future<String> getAssets() async {
    String error = "";
    String url = kWsUrlDoc;
    var req;
    Client client = Client();
    Map<String, String> userHeader = {"Authorization": "Bearer ${kWsToken}", "Content-Type": "application/json"};
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
}

