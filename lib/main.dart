import 'package:flutter/material.dart';

import 'utils/const.dart';
import 'presentation/pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: kTitle,home: Pages());
  }
}
