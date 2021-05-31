import 'dart:async';
import 'dart:convert';

import 'package:fingraph/model/asset.dart';
import 'package:fingraph/model/dimension.dart';
import 'package:fingraph/model/src_api.dart';
import 'package:fingraph/model/tick.dart';
import 'package:fingraph/model/wsmsg.dart';
import 'package:fingraph/utils/const.dart';

class TestData<T extends Dimension> extends SrcApi {
  List<Asset> assets = [];

  TestData() {
    print("* testdata()");
  }

  DateTime _dt = DateTime.now();
  StreamSubscription<dynamic> _sub;

  Stream<String> _tickStream(DateTime dt) async* {
    try {
      for(var i=0; i < kMaxLenData; i++) {
        await Future.delayed(Dimension.addDt);
        Tick tick =  Tick().getRandom(dt);
        dt = tick.d;
        WsMsg msg = WsMsg(jsonrpc: "2.0", method: "q", params: json.encode(tick.toJson()));
        //print("* testdata.dataStream: $msg");
        yield json.encode(msg.toJson());
      }
    } catch (e) {
      print("* _tickStream.error: ${e.toString()}");
    }
  }

  @override
  bool start(String symbol, OnData onData, {OnError onError}) {
    bool res = false;
    print("* testdata.start");
    try {
      final Stream<String> stream = _tickStream(_dt);
      if(_sub != null) _sub.cancel();
      _sub = stream.listen(onData, onError: onError ?? _onError, onDone: _onDone);
      res = true;
    } catch (e) {
      print("* testdata.catch error: ${e.toString()}");
    }
    return res;
  }
  //void _testData(dynamic msg) => print("* testdata.onData: $msg");
  void _onError(Object error) => print("* testdata._onError: $error");

  void _onDone() {
    _sub?.cancel();
    print("* testdata._onDone");
  }

  @override
  void stop() {
    _sub?.cancel();
    print("* testdata.stop");
  }

  @override
  Future<String> getAssets() async {
    return "* testdata.getAssets";
  }

}

