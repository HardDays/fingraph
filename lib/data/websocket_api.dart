import 'package:fingraph/model/src_api.dart';
import 'package:fingraph/utils/const.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
//import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketSrc implements SrcApi {

  // Content-Type: application/json
  // Authorization: Bearer <TOKEN>
  final IOWebSocketChannel _channel = IOWebSocketChannel.connect(kWsUrl);

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

  // channel.stream.listen((message) {
  //   channel.sink.add('received!');
  //   channel.sink.close(status.goingAway);
  // });

  @override
  Stream getData(DataType type) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<bool> iniSrc() {
    // TODO: implement iniSrc
    throw UnimplementedError();
  }

  @override
  Future<void> start(DataType type) {
    // TODO: implement start
    throw UnimplementedError();
  }

  @override
  void stop(DataType type) {
    // TODO: implement stop
  }
}