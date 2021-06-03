import 'dart:math';

import 'dimension.dart';

class Ohlc extends Dimension {
  DateTime d;
  double o;
  double h;
  double l;
  double c;

  Ohlc({this.d, this.o, this.h, this.l, this.c});

  factory Ohlc.fromJson(Map<String, dynamic> json) {
    return Ohlc(
      d: DateTime.fromMillisecondsSinceEpoch(json['d']),
      o: (json['o'] as num)?.toDouble(), // open
      h: (json['h'] as num)?.toDouble(), // hight
      l: (json['l'] as num)?.toDouble(), // low
      c: (json['c'] as num)?.toDouble()  // close
    );
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
    'd': this.d?.millisecondsSinceEpoch, //.toIso8601String(),
    'o': this.o,
    'h': this.h,
    'l': this.l,
    'c': this.c
  };

  factory Ohlc.rand(DateTime dt) {
    // {"d":1620345600000,"o":0.94661,"h":0.94671,"l":0.94647, "c":0.94659}
    var _rand = Random();
    double o = (0.9465 + ((_rand.nextInt(99).toDouble() - 45.0) / 1000000));
    double h = (0.9465 + ((_rand.nextInt(99).toDouble() - 45.0) / 1000000));
    double l = (0.9465 + ((_rand.nextInt(99).toDouble() - 45.0) / 1000000));
    double c = (0.9465 + ((_rand.nextInt(99).toDouble() - 45.0) / 1000000));
    // normalized random values for canle chart
    List<double> ls = [o, h, l, c];
    ls.sort();
    l = ls[0];
    h = ls[3];
    int i = _rand.nextInt(100) % 2;
    int j = (i + 1) % 2;
    o = ls[i + 1];
    c = ls[j + 1];

    return Ohlc(
      d: dt, //dt.add(Dimension.addDt),
      o: o, h: h, l: l, c: c
    );
  }

  @override
  Dimension getRandom(DateTime dt) {
    return Ohlc.rand(dt);
  }
}