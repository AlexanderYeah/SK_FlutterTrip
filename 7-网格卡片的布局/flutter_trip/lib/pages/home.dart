import 'dart:convert';
import 'dart:core'; 

import 'package:flutter/material.dart';
// 导入swiper 组件
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/localNav.dart';

const APPBAR_SCROLL_OFFSET = 200;
class HomePage extends StatefulWidget
{
    // 重写Create State 方法
    @override
    _HomePageState createState() => _HomePageState();

}


class _HomePageState extends State<HomePage>
{

    //定义一个AppBar 的透明度默认值
    double appBarAlpha = 0;
    //
    String resultStr = "";

    List<CommonModel> localNavList = [];

    // 导航的模型
    GridNavModel gridNavModel;


    List _imgUrls = [
      'http://www.devio.org/io/flutter_app/img/banner/100h10000000q7ght9352.jpg',
      'https://dimg04.c-ctrip.com/images/300h0u000000j05rnD96B_C_500_280.jpg',
      'http://pages.ctrip.com/hotel/201811/jdsc_640es_tab1.jpg'
    ];


    loadData() async {
      try{
          HomeModel model = await HomeDao.fetch();
          setState(() {            
            localNavList = model.localNavList;          
            gridNavModel = model.gridNav;
  
          });
           
      }catch (e){

          print(e);
  
      }
    }

    @override
    void initState() {
      // TODO: implement initState
      loadData();
      super.initState();

    } 


    @override  
    Widget build(BuildContext context) {
      return Scaffold(
        // MediaQuery.removePadding 移除顶部的 padding
        // 使用Stack 的作用就是让AppBar 叠加在上面
        backgroundColor: Colors.white,
        body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
          removeTop: true,
          context: context,
          // 监听列表的滚动
          child: NotificationListener(
            
            // 滚动的回调
            onNotification: (scrollNotifation){
                // 判断ListView滚动的效果
                if (scrollNotifation is ScrollUpdateNotification && scrollNotifation.depth == 0){
                  // 滚动且是列表滚动的的的时候
                  double offset =  scrollNotifation.metrics.pixels;
                  print(offset);
                  double  alpha =  offset / APPBAR_SCROLL_OFFSET;
                  if(alpha < 0){
                    alpha =  0;
                  }else if (alpha > 0){
                    alpha =  1;
                  }
                  
                  setState(() {
                    appBarAlpha = alpha;
                  });
                  print(alpha);
                   
                }
              
            },  
            child: ListView(
            children: <Widget>[
                Column(
                children: <Widget>[
                  Container(
                    height: 160,
                    // 
                    child:Swiper(
                        itemCount: _imgUrls.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context,int index){
                          // 获取图片
                          return Image.network(
                              _imgUrls[index],
                              // 适配方式
                              fit: BoxFit.fill,
                          );
                        },
                        // 添加一个页码指示器
                        pagination: SwiperPagination(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 10, 7, 4),
                    child: LocalNav(localNavList: localNavList),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 10, 7, 4),
                    child: GridNav(gridNavModel: gridNavModel),
                  ),
                  
                  Container(
                    height: 800,
                    child: ListTile(title: Text(resultStr),),
                  )

                ],
              ),
              ],

            ),
            ),
          ),
          // 创建AppBar
          Opacity(
            // 当列表滚动的时候 改变其透明度的值
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Center(
                child: Padding(padding: EdgeInsets.only(top: 20),
                child: Text('首页'),),
                
              ),
            ),
          )



          ],
          
        )
      );
    }

}