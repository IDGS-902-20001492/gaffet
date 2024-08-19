import 'package:flutter/material.dart';
import 'package:gaffet/models/employee.dart';
import 'package:gaffet/screens/page1.dart';
import 'package:gaffet/screens/page2.dart';

class HomeScreen extends StatefulWidget {
  final Employee employee;

  HomeScreen({required this.employee});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    setState(() {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Page1(employee: widget.employee),
      Page2(employee: widget.employee),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido(a)'),
        automaticallyImplyLeading: false,
      ),
      body: PageView(
        controller: _pageController,
        children: _widgetOptions,
        onPageChanged: (index) {
          setState(() {
          });
        },
      ),
    );
  }
}
