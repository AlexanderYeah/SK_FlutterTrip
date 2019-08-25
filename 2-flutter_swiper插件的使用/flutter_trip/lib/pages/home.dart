import 'package:flutter/material.dart';
// 导入swiper 组件
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget
{
    // 重写Create State 方法
    @override
    _HomePageState createState() => _HomePageState();

}


class _HomePageState extends State<HomePage>
{

    List _imgUrls = [
      'http://pic1.nipic.com/2008-12-05/200812584425541_2.jpg',
      'http://pic18.nipic.com/20111129/4155754_234055006000_2.jpg',
      'http://b-ssl.duitang.com/uploads/item/201412/25/20141225204152_aYEc3.jpeg'
    ];

    @override  
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Column(
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
              )
            ],
          ),
        )
      );
    }

}