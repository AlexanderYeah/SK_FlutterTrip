import 'package:flutter/material.dart';


class HomePage extends StatefulWidget
{
    // 重写Create State 方法
    @override
    _HomePageState createState() => _HomePageState();

}


class _HomePageState extends State<HomePage>
{

    final PageController _controller = PageController(
      initialPage: 0,
    );

    @override  
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Text("首页"),
        )
      );
    }

}