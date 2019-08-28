import 'dart:convert';
import 'dart:core'; 

import 'package:flutter/material.dart';
// 导入swiper 组件
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/home_model.dart';
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

    List _imgUrls = [
      'http://pic1.nipic.com/2008-12-05/200812584425541_2.jpg',
      'http://pic18.nipic.com/20111129/4155754_234055006000_2.jpg',
      'http://b-ssl.duitang.com/uploads/item/201412/25/20141225204152_aYEc3.jpeg'
    ];


    loadData() async {
      try{
          HomeModel model = await HomeDao.fetch();
          setState(() {            
            localNavList = model.localNavList;          
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