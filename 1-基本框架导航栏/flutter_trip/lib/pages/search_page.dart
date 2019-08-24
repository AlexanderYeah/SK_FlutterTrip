import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget
{
    // 重写Create State 方法
    @override
    _SearchPageState createState() => _SearchPageState();

}


class _SearchPageState extends State<SearchPage>
{

    final PageController _controller = PageController(
      initialPage: 0,
    );

    @override  
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Text("搜索"),
        )
      );
    }

}