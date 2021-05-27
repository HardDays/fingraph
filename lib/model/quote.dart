class Quote {
  DateTime d;
  double q;

  Quote({this.d, this.q});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      d: DateTime.fromMillisecondsSinceEpoch(json['d']),
      q: (json['q'] as num)?.toDouble());
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
    'd': this.d?.toIso8601String(),
    'q': this.q
  };
}
