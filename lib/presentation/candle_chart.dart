import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/repository.dart';
import '../model/ohlc.dart';
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
  DateTime _dmin;
  DateTime _dmax;
  Repository get _repository => widget.rp;

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
    _dmin = _repository.chunkQuote.first.d;
    _dmax = _repository.chunkQuote.last.d;
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
          primaryXAxis: DateTimeAxis(),
          title: ChartTitle(text: 'Candle chart'),
          legend: Legend(isVisible: false),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<Ohlc, DateTime>>[_getData()],
          onActualRangeChanged: _actRange,
          zoomPanBehavior: _zoomPanBehavior,
          onZoomEnd: _zoomEnd,
        ),
      ),
      MinMax(context, _dmin, _dmax),
    ]);
  }

  void _zoomEnd(ZoomPanArgs args) {
    print("* onZoomEnd");
    if (args.axis is DateTimeAxis) {
      setState(() {});
    }
  }

  CandleSeries<Ohlc, DateTime> _getData() {
    return CandleSeries(
        dataSource: _repository.chunkOhlc,
        xValueMapper: (Ohlc sales, _) => sales.d, // sales.d.toIso8601String(),
        lowValueMapper: (Ohlc sales, _) => sales.l,
        highValueMapper: (Ohlc sales, _) => sales.h,
        openValueMapper: (Ohlc sales, _) => sales.o,
        closeValueMapper: (Ohlc sales, _) => sales.c,
      name: 'Sales',
      dataLabelSettings: DataLabelSettings(isVisible: false),
      onRendererCreated: (ChartSeriesController controller) {
        _repository.setControllerCandle(controller);
      },
    );
  }

  //ChartActualRangeChangedCallback
   void _actRange(ActualRangeChangedArgs args) {
    if (args.orientation == AxisOrientation.horizontal) {
      print("* Candle _actRange() visibleMinD=${args.visibleMin}, visibleMaxD=${args.visibleMax}");
      _dmin = DateTime.fromMillisecondsSinceEpoch(args.visibleMin);
      _dmax = DateTime.fromMillisecondsSinceEpoch(args.visibleMax);
    }
  }
}
