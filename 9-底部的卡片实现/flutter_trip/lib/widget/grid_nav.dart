import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class GridNav extends StatelessWidget{

  // final 
  final GridNavModel gridNavModel;

  const GridNav({Key key,@required this.gridNavModel}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // 卡片分为上中下三个部分布局



    return  PhysicalModel(
      color: Colors.transparent,
      // 圆角设置为6
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
      children: _gridNavItems(context)
      ),
    );
  }

  _gridNavItems(BuildContext context){

    List<Widget> items = [];
    if(gridNavModel == null)return null;
    // 酒店
    if(gridNavModel.hotel != null){
        items.add(_gridNavItem(context,gridNavModel.hotel,true));
    }
    // 航班
    if(gridNavModel.flight != null){
       items.add(_gridNavItem(context,gridNavModel.flight,false));     
    }
    // 门票
    if(gridNavModel.travel != null){
        items.add(_gridNavItem(context,gridNavModel.travel,false));    
    }
    return items;

  }
  // 创建第一个列的Item
  _gridNavItem(BuildContext context,GridNavItem gridNavItem,bool isFirst){
      List<Widget> items = [];
      items.add(_mainItem(context,gridNavItem.mainItem));  
      items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));  
      items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));  
      List<Widget> expandsItems = [];
      items.forEach((item){
          expandsItems.add(
            Expanded(child: item,flex: 1)
          );
      });

      // 渐变颜色开始的颜色
      Color startColor = Color(int.parse('0xff' + gridNavItem.startColor));
      Color endColor = Color(int.parse('0xff' + gridNavItem.endColor));

      return Container(
        height: 88,
        margin: isFirst?null:EdgeInsets.only(top:3),
        // 边框颜色
        decoration: BoxDecoration(
          // 线性渐变颜色
          gradient: LinearGradient(colors: [startColor,endColor])
        ),
        child: Row(
          children: expandsItems
        ),
      );
  }

  // 左边的第一个大的Item
  _mainItem(BuildContext context,CommonModel model){
    return _wrapGesture(context, Stack(

          // 居中方式
          alignment: Alignment.topCenter,
          children: <Widget>[
            Image.network(
              model.icon,
              // 显示方法
              fit: BoxFit.contain,
              // 宽和高
              width: 121,
              height: 80,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Text(model.title,
              style: TextStyle(fontSize: 15,
              color: Colors.white),
            )),
          ],
      ), model);
  }

  // 右边的两列
  _doubleItem(BuildContext context,CommonModel topItem,CommonModel bottomItem){
   return Column(
     children: <Widget>[
      // 文字占满空间
      Expanded(
        child: _item(context,topItem,true),
      ),
      Expanded(
        child: _item(context,bottomItem,true),
      )           
     ],
   ); 
  }
  _item(BuildContext context,CommonModel item,bool isFirst){
    // 水平方向上撑满
    BorderSide border = BorderSide(color:Colors.white,width: 1);
    return  FractionallySizedBox(
      // 宽度撑满父布局
      widthFactor: 1,
      // 因为有分割线 如果是上面的话 就是设置分割线 如果是底部的分割线 不设置分割线
      child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: border,
              bottom: isFirst?border:BorderSide.none,
            ),
          ),
          // 文字居中
          child: _wrapGesture(context, Center(
            child: Text(item.title,style: TextStyle(color: Colors.white,fontSize: 14),),
          ),item)
      ),
    );   
  }


  // 包裹点击事件

  _wrapGesture(BuildContext context,Widget widget,CommonModel model){
    return GestureDetector(
      onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => WebView(url:"https://www.baidu.com/",
            statusBarColor: model.statusBarColor,
            hideAppBar: model.hideAppBar,
            title: model.title,            
            ),
          ));
      },
      child: widget,
    );
  }



}

 