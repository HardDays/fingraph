import 'dart:convert';
import 'package:fingraph/model/ohlc.dart';
import 'package:fingraph/model/tick.dart';
import 'package:fingraph/model/wsmsg.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/testdata_api.dart';
//import '../data/websocket_api.dart';
import '../model/dimension.dart';
import '../model/src_api.dart';
import '../utils/const.dart';

enum TypeChart { Cartesian, Candle }

class Repository with ChangeNotifier  {
  final SrcApi src = TestData<Tick>(); // WebSocketSrc();

  List<dynamic> chunkData = [];

  ChartSeriesController _controller;
  DateTime _dmin;
  DateTime _dmax;
  String _symbol;

  bool _isStart = false;
  bool get isStart => _isStart;

  DateTime get dmin => _dmin;
  DateTime get dmax => _dmax;

  void setDTBorder(DateTime min, DateTime max) {
    _dmin = min ?? DateTime(2021);
    _dmax = max ?? DateTime(2021);
    notifyListeners();
  }

  void setChartController(ChartSeriesController c) => _controller = c;

  Repository() {
    // получаем список доступных наборов данных (для выбора в дальнейшем)
    //src.getAssets();
  }

  void iniData() {
    chunkData.clear();
    // TODO реализовать выбор ассета из списка
    _symbol = "tick.aud_usd_afx";
    //setDTBorder(chunkData.first.d, chunkData.last.d);
  }

  void onStartStop() {
    if(!_isStart) {
      chunkData.clear();
      _isStart = src.start(_symbol, _onData, onError: _onError);
    } else {
      _isStart = false;
      src.stop();
    }
    notifyListeners();
  }

  void _onError(Object error) {
    _isStart = false;
    print("* repository._onError: $error");
    notifyListeners();
  }

  // add a new item in list
  void _onData(dynamic jsonMsg) {
    int len = chunkData.length;

    WsMsg wsMsg;
    Dimension value;
    try {
      wsMsg = WsMsg.fromJson(json.decode(jsonMsg));
      if(wsMsg.method == kWsMethodTick) {
        value = Tick.fromJson(json.decode(wsMsg.params));
//        print("* repository.onData.value: ${json.encode(value.toJson())}");
      }
      if(wsMsg.method == kWsMethodOhlc) {
        value = Ohlc.fromJson(json.decode(wsMsg.params));
      }
      chunkData.add(value);
      if(chunkData.length > kMaxLenData) {
        chunkData.removeRange(0, 0);
        _controller?.updateDataSource(addedDataIndex: len, removedDataIndex: 0);
      } else {
        _controller?.updateDataSource(addedDataIndex: len, updatedDataIndex: len-1);
        _controller?.seriesRenderer;//.animate();
      }
      // при обновлении, должно вызываться через ChartActualRangeChangedCallback
      // но если потребуется - добавить:
      //setDTBorder(chunkData.first.d, chunkData.last.d);
    } catch (e) {
      print("* repository.onData.error: ${e.toString()}");
    }
  }

}
