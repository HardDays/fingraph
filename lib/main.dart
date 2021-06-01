import 'package:fingraph/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils/const.dart';
import 'presentation/pages.dart';

void main() => runApp(
    ChangeNotifierProvider(
      create: (context) => Repository(),
      child: MyApp(),)
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: kTitle,home: Pages());
  }
}
