/*
    "id": 299,
    "rate": 0.55,
    "rate_longer_5m": 0.44,
    "available": false,
    "session_start_time": "2021-05-27T19:00:00Z",
    "session_end_time": "2021-05-28T06:00:00Z",
    "next_session_start_time": "2021-05-28T19:00:00Z",
    "symbol": "GBP/JPY:OTC",
    "SessionSource": "inverted_parent",
    "RateSource": "manual",
    "enabled": false,
    "category": "Forex",
    "deals_opening_allowed": false,
    "friendly_name": "GBP/JPY:OTC",
    "is_otc": true,
    "sparkline": null
*/

class Asset {
  int id;
  double rate;
  double rate_longer_5m;
  bool available;
  DateTime session_start_time;
  DateTime session_end_time;
  DateTime next_session_start_time;
  String symbol;
  String SessionSource;
  String RateSource;
  bool enabled;
  String category;
  bool deals_opening_allowed;
  String friendly_name;
  bool is_otc;
  String sparkline;

  Asset({
      this.id,
      this.rate,
      this.rate_longer_5m,
      this.available,
      this.session_start_time,
      this.session_end_time,
      this.next_session_start_time,
      this.symbol,
      this.SessionSource,
      this.RateSource,
      this.enabled,
      this.category,
      this.deals_opening_allowed,
      this.friendly_name,
      this.is_otc,
      this.sparkline
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'] as int,
      rate: (json['rate'] as num)?.toDouble(),
      rate_longer_5m: (json['rate_longer_5m'] as num)?.toDouble(),
      available: json['available'] as bool,
      session_start_time: json['session_start_time'] == null
          ? null
          : DateTime.parse(json['session_start_time'] as String),
      session_end_time: json['session_end_time'] == null
          ? null
          : DateTime.parse(json['session_end_time'] as String),
      next_session_start_time: json['next_session_start_time'] == null
          ? null
          : DateTime.parse(json['next_session_start_time'] as String),
      symbol: json['symbol'] as String,
      SessionSource: json['SessionSource'] as String,
      RateSource: json['RateSource'] as String,
      enabled: json['enabled'] as bool,
      category: json['category'] as String,
      deals_opening_allowed: json['deals_opening_allowed'] as bool,
      friendly_name: json['friendly_name'] as String,
      is_otc: json['is_otc'] as bool,
      sparkline: json['sparkline'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': this.id,
    'rate': this.rate,
    'rate_longer_5m': this.rate_longer_5m,
    'available': this.available,
    'session_start_time': this.session_start_time?.toIso8601String(),
    'session_end_time': this.session_end_time?.toIso8601String(),
    'next_session_start_time': this.next_session_start_time?.toIso8601String(),
    'symbol': this.symbol,
    'SessionSource': this.SessionSource,
    'RateSource': this.RateSource,
    'enabled': this.enabled,
    'category': this.category,
    'deals_opening_allowed': this.deals_opening_allowed,
    'friendly_name': this.friendly_name,
    'is_otc': this.is_otc,
    'sparkline': this.sparkline,
  };
}