import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/repository.dart';
import '../model/quote.dart';
import '../utils/util.dart';
import 'minmax_widget.dart';

class CartesianChart extends StatefulWidget {
  final Repository rp;
  CartesianChart({Key key, this.rp}) : super(key: key);

  @override
  _CartesianChartState createState() => _CartesianChartState();
}

class _CartesianChartState extends State<CartesianChart> {
  ZoomPanBehavior _zoomPanBehavior;
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
            axisLabelFormatter: Util.tsFormatter,
            primaryXAxis: DateTimeAxis(
              dateFormat: DateFormat.ms()
            ),
            title: ChartTitle(text: 'Cartesian chart'),
            legend: Legend(isVisible: false),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<Quote, DateTime>>[_getData()],
            onActualRangeChanged: _actRange,
            zoomPanBehavior: _zoomPanBehavior,
            onZoomEnd: _zoomEnd,
            ),
      ),
      MinMax(context, _dmin, _dmax),
    ]);
  }

  void _zoomEnd(ZoomPanArgs args) {
    if (args.axis is DateTimeAxis) {
      setState(() {});
    }
  }

  LineSeries<Quote, DateTime> _getData() {
    return LineSeries<Quote, DateTime>(
      dataSource: _repository.chunkQuote,
      xValueMapper: (Quote sales, _) => sales.d,
      yValueMapper: (Quote sales, _) => sales.q,
      name: 'Sales',
      markerSettings: MarkerSettings(
          isVisible: true, height: 4, width: 4, shape: DataMarkerType.circle, borderWidth: 2, borderColor: Colors.red),
      dataLabelSettings: DataLabelSettings(isVisible: false),
      onRendererCreated: (ChartSeriesController controller) {
        _repository.setControllerCartesian(controller);
      },
    );
  }
  //ChartActualRangeChangedCallback
  void _actRange(ActualRangeChangedArgs args) {
    if (args.orientation == AxisOrientation.horizontal) {
      print("* Cartesian _actRange() visibleMinD=${args.visibleMin}, visibleMaxD=${args.visibleMax}");
      _dmin = DateTime.fromMillisecondsSinceEpoch(args.visibleMin);
      _dmax = DateTime.fromMillisecondsSinceEpoch(args.visibleMax);
    }
  }
}
