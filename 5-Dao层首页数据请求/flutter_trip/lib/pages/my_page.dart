import 'package:flutter/material.dart';


class MyPage extends StatefulWidget
{
    // 重写Create State 方法
    @override
    _MyPageState createState() => _MyPageState();
}


class _MyPageState extends State<MyPage>
{

    @override  
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Text("我的"),
        )
      );
    }

}