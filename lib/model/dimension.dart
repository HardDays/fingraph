abstract class Dimension {
//  DateTime d;

  static const Duration addDt = Duration(milliseconds: 200);
  //static const Duration addDt = Duration(seconds: 1);

  Dimension();

  Map<String, dynamic> toJson();

  Dimension getRandom(DateTime dt);

}