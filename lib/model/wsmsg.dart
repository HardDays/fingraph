import 'dart:core';

// example response:
// {"jsonrpc":"2.0","method":"q","params":{"i":56, "d":1622444215131, "q":0.77269}}

class WsMsg<T> {
  String jsonrpc;
  String method;
  String params;

  WsMsg({this.jsonrpc, this.method, this.params});

  factory WsMsg.fromJson(Map<String, dynamic> json) {
    return WsMsg(
        jsonrpc: json['jsonrpc'] as String,
        method: json['method'] as String,
        params: json['params'] as String);
    }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'jsonrpc': this.jsonrpc,
    'method': this.method,
    'params': this.params
  };

}