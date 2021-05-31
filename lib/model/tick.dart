import 'dart:math';
import 'dimension.dart';

class Tick extends Dimension {
  int i;
  DateTime d;
  double q;

  Tick({this.i, this.d, this.q});

  @override
  factory Tick.fromJson(Map<String, dynamic> json) {
    return Tick(
      i: json['i'] as int,
      d: DateTime.fromMillisecondsSinceEpoch(json['d']),
      q: (json['q'] as num)?.toDouble());
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'i': this.i,
    'd': this.d?.millisecondsSinceEpoch, // toIso8601String(),
    'q': this.q
  };

  factory Tick.rand(DateTime dt) {
    return Tick(
        i: 0,
        d: dt.add(Dimension.addDt),
        q: (0.90 + (Random().nextInt(90).toDouble() / 1000))
    );
  }

  @override
  Dimension getRandom(DateTime dt) {
    return Tick.rand(dt);
  }

}
