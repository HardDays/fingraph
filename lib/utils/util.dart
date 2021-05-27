import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Util {

  static ChartAxisLabel tsFormatter(AxisLabelRenderDetails alrd) {
    return alrd.orientation == AxisOrientation.horizontal
        ? ChartAxisLabel(
        (alrd.text.length > 20)
            ? alrd.text.substring(alrd.text.length - 20, alrd.text.length)
            : alrd.text,
        TextStyle(color: Colors.black))
        : ChartAxisLabel(alrd.text, TextStyle(color: Colors.red));
  }
}