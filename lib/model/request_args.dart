import 'package:intl/intl.dart';

import 'dimension_type.dart';

class RequestArgs {
  //  period_name тиковые: 2t, 5t, 15t, 30t, 60t, 180t
  //  period_name - OHLC: 15o, 30o, 60o, 180o
  // /chunksQuotesHistory/<YYYYMMDD>/<asset_id>/<period_name>/<period_id>
  // /chunksQuotesHistoryOhlc/<YYYYMMDD>/<asset_id>/<period_name>/<period_id>

  DimensionType type;
  DateTime d;
  int assetId;
  int minutes;
  String assetSymbol;

  RequestArgs({this.type, this.d, this.assetId, this.minutes}) {
    this.type = type ?? DimensionType.tick;
    this.d = d ?? DateTime.now().add(Duration(hours: -7));
    this.assetId = assetId ?? 56;
    this.minutes = minutes ?? 15;
    this.assetSymbol = _getAssetSymbolNormalize("");
  }

  @override
  String toString() {
    return "/${type == DimensionType.tick
        ? 'chunksQuotesHistory': 'chunksQuotesHistoryOhlc'}/${DateFormat('yyyyMMdd').format(d)}/$assetId"
    + "/${(minutes ?? 15).toString()}${type == DimensionType.tick ? 't' : 'o'}"
    + "/${_getPeriodId(d, minutes).toString()}"
    + ".chunk";
  }

  String _getAssetSymbolNormalize(String symbol) {
    return "tick.aud_usd_afx";
  }

  int _getPeriodId(DateTime dateTime, int minutes) {
    return dateTime.millisecondsSinceEpoch ~/ (60000 * minutes);
  }
}