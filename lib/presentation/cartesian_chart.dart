import 'package:fingraph/model/dimension_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/repository.dart';
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
  Repository get _rp => widget.rp;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
        enablePinching: true,
        zoomMode: ZoomMode.x,
        enablePanning: true,
        enableSelectionZooming: true,
        enableDoubleTapZooming: true,
        enableMouseWheelZooming: true);
    _rp.iniData(DimensionType.tick);
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
            primaryXAxis: DateTimeAxis(dateFormat: DateFormat.Hms(), intervalType: DateTimeIntervalType.seconds),
            primaryYAxis: NumericAxis(
                //minimum: 0.5,
                // visibleMaximum: 2.0
                //, visibleMinimum: 0.5
                //anchorRangeToVisiblePoints: true
                ),
            title: ChartTitle(text: 'Cartesian chart'),
            legend: Legend(isVisible: false),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<dynamic, DateTime>>[_getData()],
            onActualRangeChanged: _actRange,
            zoomPanBehavior: _zoomPanBehavior,
            onZoomEnd: _zoomEnd,
            enableAxisAnimation: true),
      ),
      MinMax(context),
    ]);
  }

  void _zoomEnd(ZoomPanArgs args) {
    if (args.axis is DateTimeAxis) {
      //setState(() {});
    }
  }

  LineSeries<dynamic, DateTime> _getData() {
    return LineSeries<dynamic, DateTime>(
      dataSource: _rp.chunkData,
      xValueMapper: (dynamic tick, _) => tick.d,
      yValueMapper: (dynamic tick, _) => tick.q,
      name: 'Sales',
      // markerSettings: MarkerSettings(
      //     isVisible: true, height: 4, width: 4, shape: DataMarkerType.circle, borderWidth: 2, borderColor: Colors.red),
      dataLabelSettings: DataLabelSettings(isVisible: false),
      onRendererCreated: (ChartSeriesController controller) {
        _rp.setChartController(controller);
      },
    );
  }

  //ChartActualRangeChangedCallback
  void _actRange(ActualRangeChangedArgs args) {
    if (args.orientation == AxisOrientation.horizontal) {
      //print("* Cartesian _actRange() visibleMinD=${args.visibleMin}, visibleMaxD=${args.visibleMax}");
      _rp.setDTBorder(
          DateTime.fromMillisecondsSinceEpoch(args.visibleMin), DateTime.fromMillisecondsSinceEpoch(args.visibleMax));
    }
    // if (args.orientation == AxisOrientation.vertical) {
    //   //print("* Cartesian _actRange() visibleMinD=${args.visibleMin}, visibleMaxD=${args.visibleMax}");
    //   args.actualMin = 0.8;
    //   args.actualMax = 1.0;
    // }
  }
}

