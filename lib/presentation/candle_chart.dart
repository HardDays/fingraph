import 'dart:math';
import 'package:fingraph/model/dimension_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/repository.dart';
import 'minmax_widget.dart';

class CandleChart extends StatefulWidget {
  final Repository rp;
  CandleChart({Key key, this.rp}) : super(key: key);

  @override
  _CandleChartState createState() => _CandleChartState();
}

class _CandleChartState extends State<CandleChart> {
  ZoomPanBehavior _zoomPanBehavior;
  final Random r = Random();
  Repository get _rp => widget.rp;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
        enablePinching: true,
        zoomMode: ZoomMode.x,
        enablePanning: true,
        enableSelectionZooming: true,
        enableDoubleTapZooming: true,
        enableMouseWheelZooming: true
    );
    _rp.iniData(DimensionType.ohlc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //Initialize the chart widget
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
          //axisLabelFormatter: Util.tsFormatter,
          primaryXAxis: DateTimeAxis(dateFormat: DateFormat.Hms(), intervalType: DateTimeIntervalType.seconds),
          title: ChartTitle(text: 'Candle chart'),
          legend: Legend(isVisible: false),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<dynamic, DateTime>>[_getData()],
          onActualRangeChanged: _actRange,
          zoomPanBehavior: _zoomPanBehavior,
          onZoomEnd: _zoomEnd,
        ),
      ),
      MinMax(context),
    ]);
  }

  void _zoomEnd(ZoomPanArgs args) {
    if (args.axis is DateTimeAxis) {
      //setState(() {});
    }
  }

  CandleSeries<dynamic, DateTime> _getData() {
    return CandleSeries(
        dataSource: _rp.chunkData,
        xValueMapper: (dynamic sales, _) => sales.d, // sales.d.toIso8601String(),
        lowValueMapper: (dynamic sales, _) => sales.l,
        highValueMapper: (dynamic sales, _) => sales.h,
        openValueMapper: (dynamic sales, _) => sales.o,
        closeValueMapper: (dynamic sales, _) => sales.c,
      name: 'Sales',
      dataLabelSettings: DataLabelSettings(isVisible: false),
      onRendererCreated: (ChartSeriesController controller) {
        _rp.setChartController(controller);
      },
    );
  }

  //ChartActualRangeChangedCallback
   void _actRange(ActualRangeChangedArgs args) {
    if (args.orientation == AxisOrientation.horizontal) {
      //print("* Candle _actRange() visibleMinD=${args.visibleMin}, visibleMaxD=${args.visibleMax}");
      _rp.setDTBorder(
          DateTime.fromMillisecondsSinceEpoch(args.visibleMin),
          DateTime.fromMillisecondsSinceEpoch(args.visibleMax)
      );
    }
  }
}
