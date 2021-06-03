import 'dart:convert';
import 'package:fingraph/model/dimension_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/testdata_api.dart';
import '../data/websocket_api.dart';
import '../model/tick.dart';
import '../model/asset.dart';
import '../model/request_args.dart';
import '../model/wsmsg.dart';
import '../model/dimension.dart';
import '../model/src_api.dart';
import '../utils/util.dart';
import '../utils/const.dart';

enum TypeChart { Cartesian, Candle }

class Repository with ChangeNotifier  {

  // TODO В интерфейсе нужно сделать переключатель источника данных
  final SrcApi src = kTestData ? TestData<Tick>() : WebSocketSrc();

  List<Asset> assets = [];
  List<dynamic> chunkData = [];

  ChartSeriesController _controller;
  DateTime _dmin;
  DateTime _dmax;
  RequestArgs requestArgs = RequestArgs();

  bool _isStart = false;
  bool get isStart => _isStart;
  bool _assetsReady = false;
  bool get assetsReady => _assetsReady;

  DateTime get dmin => _dmin;
  DateTime get dmax => _dmax;

  void setDTBorder(DateTime min, DateTime max) {
    _dmin = min ?? DateTime(2021);
    _dmax = max ?? DateTime(2021);
    // реально данные (dmin, dmax) актуальные, но отобразить их не получилось пока
    // при включении: ошибка при инициализации графика (нужно убрать вызов setState() в графике)
    // notifyListeners();
    if(_isStart) {
      notifyListeners();
    }
  }

  void setChartController(ChartSeriesController c) => _controller = c;

  Repository() {
    // getting available assets (to select later)
    getAssets();
  }

  void iniData(DimensionType dtype) {
    this.assets.clear();
    requestArgs = RequestArgs(type: dtype);
    src.requestArgs = requestArgs;
  }

  void getAssets() {
    this.assets.clear();
    src.getAssets().then((_assets) {
      this.assets = _assets;
      _assetsReady = true;
    }).catchError((error) => Util.ShowError("Ошибка получения наборов. Попробуйте позднее"));
  }

  Future<void> onStartStop() async {
    if(!_isStart) {
      chunkData.clear();
      try {
        // depth of historical set 2 minutes
        requestArgs.minutes = 2;
        // start loading hist data
        src.getHistory(requestArgs)
            .then(_onLoad)
            .catchError(_onError);
        // start receiving live data
        _isStart = src.start(requestArgs.assetSymbol, _onData, onError: _onError);
      } catch (e) {
        print(e);
        Util.ShowError("Ошибка загрузки данных. Повторите позднее");
      }
    } else {
      _isStart = false;
      src.stop();
    }
    notifyListeners();
  }

  void _onError(Object error) {
    _isStart = false;
    src.stop();
    print("* repository._onError: $error");
    notifyListeners();
  }

  // loading historical data
  void _onLoad(List<dynamic> list) {
    print("* repository.onLoad");
    if(list.length > 0) {
      List<int> adi = list.length == 0 ? [] : List.generate(list.length, (index) => index);
      List<int> udi = chunkData.length == 0 ? [] : List.generate(chunkData.length, (index) => index + list.length);
      try {
        chunkData.insertAll(0, list);
        _controller?.updateDataSource(addedDataIndexes: adi, updatedDataIndexes: udi);
      } catch (e) {
        Util.ShowError("* repository.onLoad.error: ${e.toString()}");
      }
    }
  }

  // add a new item in list
  void _onData(dynamic jsonMsg) {
    WsMsg wsMsg;
    Dimension value;
    try {
//      print("* repository.onData: $jsonMsg");
      wsMsg = WsMsg.fromJson(json.decode(jsonMsg));
      value = wsMsg.params;
      chunkData.add(value);
      List<int> adi = [chunkData.length-1];
      List<int> udi = chunkData.length == 0 ? [] : List.generate(chunkData.length-1, (index) => index);
      _controller?.updateDataSource(addedDataIndexes: adi, updatedDataIndexes: udi);
      //_controller?.animate();
    } catch (e) {
      Util.ShowError("* repository.onData.error: ${e.toString()}");
    }
  }

}
