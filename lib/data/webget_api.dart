import 'dart:convert';

import 'package:fingraph/model/asset.dart';
import 'package:fingraph/model/ohlc.dart';
import 'package:fingraph/model/req_args.dart';
import 'package:fingraph/model/tick.dart';
import 'package:http/http.dart';
import 'package:fingraph/utils/const.dart';

class GetFromWeb {
  static final Utf8Decoder _utf8decoder = Utf8Decoder();

  Future<String> getJsonWeb(String url) async {
    String jsonString;
    var req;
    Client client = Client();
    Map<String, String> userHeader = {"Authorization": "Bearer $kWsToken", "Content-Type": "application/json"};

    print("* getJsonWeb.try: ${url}");
    req = await client.get(Uri.parse(url), headers: userHeader);
    print("* getJsonWeb.statuc Code: ${req.statusCode}");
    if (req.statusCode == 200) {
      jsonString = _utf8decoder.convert(req.bodyBytes);
      print("* getJsonWeb.jsonString.length=${jsonString.length}");
    } else {
      throw "* getJsonWeb.error: status code = ${req.statusCode.toString()}";
    }
    client?.close();
    return jsonString;
  }

  Future<List<Asset>> getAssets() async {
    List<Asset> assets = [];
    String jsonString = await getJsonWeb(kUrlAssests);
    for (var a in json.decode(jsonString)) {
      assets.add(Asset.fromJson(a));
    }
    return assets;
  }

  Future<List<Tick>> getHystoryTick(RequestArgs ra) async {
    List<Tick> data = [];
    String url = kUrlHystory + ra.toString();
    String jsonString = await getJsonWeb(url);
    for (var a in json.decode(jsonString)) {
      data.add(Tick.fromJson(a));
    }
    return data;
  }

  Future<List<Ohlc>> getHystoryOhlc(RequestArgs ra) async {
    List<Ohlc> data = [];
    String url = kUrlHystory + ra.toString();
    String jsonString = await getJsonWeb(url);
    for (var a in json.decode(jsonString)) {
      data.add(Ohlc.fromJson(a));
    }
    return data;
  }
}