class Chunk {
  DateTime d;
  double q;

  Chunk({this.d, this.q});

  factory Chunk.fromJson(Map<String, dynamic> json) {
    return Chunk(
      d: DateTime.fromMillisecondsSinceEpoch(json['d']),
      q: (json['q'] as num)?.toDouble());
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
    'd': this.d?.toIso8601String(),
    'q': this.q
  };
}
