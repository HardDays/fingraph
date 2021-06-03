import 'dart:core';
import 'package:fingraph/model/tick.dart';

import 'ohlc.dart';

// example response:
// {"jsonrpc":"2.0","method":"q","params":{"i":56, "d":1622444215131, "q":0.77269}}

class WsMsg<T> {
  int jsonrpc;
  String method;
  dynamic params;

  WsMsg({this.jsonrpc, this.method, this.params});

  factory WsMsg.fromJson(Map<String, dynamic> json) {
    String m = json['method'] as String;
    return WsMsg(
        jsonrpc: (json['jsonrpc'] as num)?.toInt(),
        method: json['method'] as String,
        params: (m == "q") ? Tick.fromJson(json['params']) : Ohlc.fromJson(json['params']));
    }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'jsonrpc': this.jsonrpc,
    'method': this.method,
    'params': this.params
  };

}