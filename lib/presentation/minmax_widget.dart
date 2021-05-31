import 'package:fingraph/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

Widget MinMax(BuildContext context) {
  final DateFormat formatter = DateFormat('ms');

  return Consumer<Repository>(
    builder: (context, rp, child) => Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Card(margin: EdgeInsets.all(8.0), child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(rp.dmin != null ? "TS min ${formatter.format(rp.dmin)}.${rp.dmin.millisecond % 1000}" : "NULL"),
              ),),
              Expanded(child: Container()),
              Card(margin: EdgeInsets.all(8.0), child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(rp.dmax != null ? "TS max ${formatter.format(rp.dmax)}.${rp.dmax.millisecond % 1000}" : "NULL"),
              ),)
            ],
          ),
        )),
  );
 }