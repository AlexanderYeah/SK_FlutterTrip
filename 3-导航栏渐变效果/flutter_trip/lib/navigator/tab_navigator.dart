import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';


class TabNavigator extends StatefulWidget
{
    // 重写Create State 方法
    @override
    _TabNavigatorState createState() => _TabNavigatorState();
}


class _TabNavigatorState extends State<TabNavigator>
{
    // 设置一个默认的颜色 和 选中的颜色
    final _defaultColor = Colors.grey;
    final _activeColor = Colors.blue;
    // 当前选中的索引
    int _currentIndex = 0;

    final PageController _controller = PageController(
      initialPage: 0,
    );

    @override  
    Widget build(BuildContext context) {
      return Scaffold(
        body: PageView(
          controller: _controller,
          children: <Widget>[
            HomePage(),
            SearchPage(),
            TravelPage(),
            MyPage(),
          ],                   
        ),
        // 设置底部的按钮 
        bottomNavigationBar: BottomNavigationBar(
          // 当前选中的索引
          currentIndex:_currentIndex,
          // 点击的方法
          onTap: (index){
               _controller.jumpToPage(index);
               setState(() {
                 _currentIndex = index;
               }); 
          },
          // 设置tabbar item 的标题一直显示
          type: BottomNavigationBarType.fixed,
          items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: _defaultColor,),
            activeIcon: Icon(Icons.home,color: _activeColor,),
            title:Text('首页',style:TextStyle(
              color: _currentIndex !=0? _defaultColor : _activeColor
            )),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,color: _defaultColor,),
            activeIcon: Icon(Icons.search,color: _activeColor,),
            title:Text('搜索',style:TextStyle(
              color: _currentIndex !=1? _defaultColor : _activeColor
            )),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt,color: _defaultColor,),
            activeIcon: Icon(Icons.camera_alt,color: _activeColor,),
            title:Text('旅拍',style:TextStyle(
              color: _currentIndex !=2? _defaultColor : _activeColor
            )),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,color: _defaultColor,),
            activeIcon: Icon(Icons.account_circle,color: _activeColor,),
            title:Text('我的',style:TextStyle(
              color: _currentIndex !=3? _defaultColor : _activeColor
            )),
          ),          
        ],),
      );
    }

}