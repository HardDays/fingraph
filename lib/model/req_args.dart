import 'package:intl/intl.dart';

import 'dimension_type.dart';

class RequestArgs {
  //  period_name тиковые: 2t, 5t, 15t, 30t, 60t, 180t
  //  period_name - OHLC: 15o, 30o, 60o, 180o
  // /chunksQuotesHistory/<YYYYMMDD>/<asset_id>/<period_name>/<period_id>
  // /chunksQuotesHistoryOhlc/<YYYYMMDD>/<asset_id>/<period_name>/<period_id>

  DimensionType type;
  DateTime d;
  String assetId;
  int minutes;
  String periodId;

  RequestArgs({this.d, this.assetId, this.minutes, this.periodId});

  @override
  String toString() {
    return "/${type == DimensionType.tick
        ? 'chunksQuotesHistory': 'chunksQuotesHistoryOhlc'}/${DateFormat('Hms').format(d)}/$assetId"
    + "${(minutes ?? 15).toString()}${type == DimensionType.tick ? 't' : 'o'}"
    + "${(d.millisecondsSinceEpoch/(60000 * minutes)).toString()}"
    + ".chunk";
  }
}