import 'package:flutter/material.dart';
import 'presentation/pages.dart';

void main() => runApp(MyApp());

const String kTitle = 'Syncfusion Flutter chart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: kTitle,home: Pages());
  }
}
