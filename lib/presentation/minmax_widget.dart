import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget MinMax(BuildContext context, DateTime dmin, DateTime dmax) {
  final DateFormat formatter = DateFormat('ms');

  return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Card(margin: EdgeInsets.all(8.0), child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(dmin != null ? "TS min ${formatter.format(dmin)}.${dmin.millisecond % 1000}" : "NULL"),
            ),),
            Expanded(child: Container()),
            Card(margin: EdgeInsets.all(8.0), child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(dmax != null ? "TS max ${formatter.format(dmax)}.${dmax.millisecond % 1000}" : "NULL"),
            ),)
          ],
        ),
      ));
 }