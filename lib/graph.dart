import 'dart:math';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'data/repository.dart';
import 'model/chunk.dart';

class GraphPage extends StatefulWidget {
  GraphPage({Key key}) : super(key: key);

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  ZoomPanBehavior _zoomPanBehavior;
  ChartSeriesController _chartSeriesController;
  final Random r = Random();
  DateTime dmin;
  DateTime dmax;
  final DateFormat formatter = DateFormat('Hms');

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x, enablePanning: true);
    iniChunkSeries1();
    dmin = chartData.first.d;
    dmax = chartData.last.d;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //Initialize the chart widget
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
            axisLabelFormatter: _axisLabelFormatter,
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Zoom and Pan Test'),
            legend: Legend(isVisible: false),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<Chunk, String>>[
              _getData(),
            ],
            onActualRangeChanged: _actRange,
            zoomPanBehavior: _zoomPanBehavior,
            // onZoomEnd: (ZoomPanArgs args) {
            //   print("* onZoomEnd");
            //   if (args.axis is DateTimeAxis) {
            //     dmin = (args.axis as DateTimeAxis).visibleMinimum;
            //     dmax = (args.axis as DateTimeAxis).visibleMaximum;
            //     print("* Min: $dmin, Max: $dmax");
            //     setState(() {});
            //   }
            // }
            ),
      ),
      Container(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(children: [Text("Xmin:"), Text("${formatter.format(dmin)}.${dmin.millisecond % 1000}")]),
            Row(children: [Text("Xmax:"), Text("${formatter.format(dmax)}.${dmin.millisecond % 1000}")]),
          ],
        ),
      )),
      Container(
          child: ElevatedButton(
              onPressed: _addPoint,
              child: Container(
                child: Text('Add a point'),
              )))
    ]);
  }

  void _addPoint() {
    //Removed a point from data source
    if (chartData.length > 10) {
      chartData.removeAt(0);
    }
    // //Added a point to the data source
    chartData.add(Chunk(d: DateTime.now(), q: 0.9 + (r.nextInt(10).toDouble() / 100)));
    //Here accessed the public method of the series.
    _chartSeriesController?.updateDataSource(
        addedDataIndexes: <int>[chartData.length - 1],
        removedDataIndexes: (chartData.length < 10 ? <int>[] : <int>[0]));
    setState(() {
      print("* chartData.length = ${chartData.length}");
      dmin = chartData.first.d;
      dmax = chartData.last.d;
    });
  }

  ChartAxisLabel _axisLabelFormatter(AxisLabelRenderDetails alrd) {
    return alrd.orientation == AxisOrientation.horizontal
        ? ChartAxisLabel(
            (alrd.text.length > 20) ? alrd.text.substring(alrd.text.length - 10, alrd.text.length - 4) : alrd.text,
            TextStyle(color: Colors.brown))
        : ChartAxisLabel(alrd.text, TextStyle(color: Colors.red));
  }

  LineSeries<Chunk, String> _getData() {
    return LineSeries<Chunk, String>(
      dataSource: chartData,
      xValueMapper: (Chunk sales, _) => sales.d.toIso8601String(),
      yValueMapper: (Chunk sales, _) => sales.q,
      name: 'Sales',
      markerSettings: MarkerSettings(
          isVisible: true, height: 4, width: 4, shape: DataMarkerType.circle, borderWidth: 2, borderColor: Colors.red),
      // Enable data label
      dataLabelSettings: DataLabelSettings(isVisible: false),
      onRendererCreated: (ChartSeriesController controller) {
        _chartSeriesController = controller;
      },
    );
  }

  ChartActualRangeChangedCallback _actRange(ActualRangeChangedArgs args) {
    if (args.orientation == AxisOrientation.horizontal) {
      print(
          "_actRange: orientation: ${args.orientation.toString()}, ${args.axisName}, actualInterval=${args.actualInterval}, actualMin=${args.actualMin}, actualMax=${args.actualMax}, visibleInterval=${args.visibleInterval}, visibleMin=${args.visibleMin}, visibleMax=${args.visibleMax}");
    }
  }
}
