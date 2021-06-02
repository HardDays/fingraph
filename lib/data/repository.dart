import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/get_from_web.dart';
import '../data/websocket_api.dart';
import '../model/asset.dart';
import '../model/request_args.dart';
import '../model/wsmsg.dart';
import '../model/dimension.dart';
import '../model/src_api.dart';
import '../utils/util.dart';

enum TypeChart { Cartesian, Candle }

class Repository with ChangeNotifier  {
//  final SrcApi src = TestData<Tick>();
  final SrcApi src = WebSocketSrc();

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
    //notifyListeners();
  }

  void setChartController(ChartSeriesController c) => _controller = c;

  Repository() {
    // getting available assets (to select later)
    getAssets();
  }

  void getAssets() {
    this.assets.clear();
    src.getAssets().then((_assets) {
      this.assets = _assets;
      _assetsReady = true;
    }).catchError((error) => Util.ShowError("Ошибка получения наборов. Попробуйте позднее"));
  }

  void iniData() {}

  Future<void> onStartStop() async {
    if(!_isStart) {
      chunkData.clear();
      try {
        // depth of historical set 2 minutes
        requestArgs = RequestArgs(minutes: 2);
        // start loading hist data
        GetFromWeb.getHystoryTick(requestArgs)
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
    List<int> adi = [];
    List<int> rdi = [];

    WsMsg wsMsg;
    Dimension value;
    try {
      print("* reposotiry.onData: $jsonMsg");
      wsMsg = WsMsg.fromJson(json.decode(jsonMsg));
      value = wsMsg.params;
      // if(chunkData.length >= 50) {
      //   chunkData.removeRange(0, 1);
      //   rdi.add(0);
      // }
      chunkData.add(value);
      adi.add(chunkData.length-1);
      _controller?.updateDataSource(addedDataIndexes: adi, removedDataIndexes: rdi);
      //_controller?.animate();
    } catch (e) {
      Util.ShowError("* repository.onData.error: ${e.toString()}");
    }
  }

}
