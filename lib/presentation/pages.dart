import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'candle_chart.dart';
import 'cartesian_chart.dart';
import '../main.dart';
import '../data/repository.dart';

class Pages extends StatefulWidget {
  static const id = 'main_page';
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  final PageController _pageController = PageController();
  final Repository _rp = Repository();
  int _page;

  @override
  void initState() {
    super.initState();
    _page = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kTitle),
      ),
      body: PageView(
        children: <Widget>[
          CartesianChart(rp: _rp),
          CandleChart(rp: _rp)
        ],
        controller: _pageController,
        onPageChanged: (page) => setState(() => _page = page),
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: _BottomNavigationBar(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),// Text(gLocale.fab_qr),
        onPressed: () => _rp.addPoint(_page == 0 ? TypeChart.Cartesian : TypeChart.Candle, null),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  Widget _BottomNavigationBar(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: BottomNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "Cartesian"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Candle")
        ],
        onTap: (page) => _pageController.jumpToPage(page),
        currentIndex: _page,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    ));
  }
}