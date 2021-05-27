class Ohlc {
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
    'd': this.d?.toIso8601String(),
    'o': this.o,
    'h': this.h,
    'l': this.l,
    'c': this.c
  };

}