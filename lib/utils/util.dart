import 'package:fingraph/model/dimension_type.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Util {

  static void ShowError(String err) {
    print("* repository.error: $err");
  }

  static ChartAxisLabel tsFormatter(AxisLabelRenderDetails alrd) {
    return alrd.orientation == AxisOrientation.horizontal
        ? ChartAxisLabel(
        (alrd.text.length > 20)
            ? alrd.text.substring(alrd.text.length - 20, alrd.text.length)
            : alrd.text,
        TextStyle(color: Colors.black))
        : ChartAxisLabel(alrd.text, TextStyle(color: Colors.red));
  }

  Future<int> menuChooceScale(BuildContext context, DimensionType type) async {
    TextStyle _textStyle = Theme.of(context).textTheme.bodyText1;
    int selScale = await showDialog(
        context: context,
        builder: (context) => SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            title: Text("Масштаб", style: Theme.of(context).textTheme.headline6),
            children: <Widget>[
              Divider(),
              type != DimensionType.tick ? Container() : SimpleDialogOption(
                  child: Text("2 мин", style: _textStyle), onPressed: () => Navigator.of(context).pop(2)),
              type != DimensionType.tick ? Container() : SimpleDialogOption(
                  child: Text("5 мин", style: _textStyle), onPressed: () => Navigator.of(context).pop(5)),
              SimpleDialogOption(
                  child: Text("15 мин", style: _textStyle), onPressed: () => Navigator.of(context).pop(15)),
              SimpleDialogOption(
                  child: Text("30 мин", style: _textStyle), onPressed: () => Navigator.of(context).pop(30)),
              SimpleDialogOption(
                  child: Text("1 час", style: _textStyle), onPressed: () => Navigator.of(context).pop(60)),
              SimpleDialogOption(
                  child: Text("3 час", style: _textStyle), onPressed: () => Navigator.of(context).pop(180))
            ]));
    return selScale;
  }

}