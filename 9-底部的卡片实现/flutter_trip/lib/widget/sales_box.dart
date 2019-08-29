import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sale_box_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class SalesBox extends StatelessWidget{
  
  final SalesBoxModel saleBox;
  // final 
  const SalesBox({Key key,@required this.saleBox}) : super(key:key);

  _items(BuildContext context){
    if (saleBox == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(context,saleBox.bigCard1,saleBox.bigCard2,true,false));
    items.add(_doubleItem(context,saleBox.smallCard1,saleBox.smallCard2,false,false));
    items.add(_doubleItem(context,saleBox.smallCard3,saleBox.smallCard4,false,true));
    
    //
    return Column(
      children: <Widget>[
        Container(
          height: 44,
          margin: EdgeInsets.only(left: 10),
          // 装饰器
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1,color: Color(0xfff2f2f2))),  
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(
                saleBox.icon,
                height: 15,
                fit:BoxFit.contain,                             
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(colors: [
                    Color(0xffff4e63),Color(0xffff6cc9)                    
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
                  ),                  
                ),
                child: GestureDetector(
                  // 点击事件
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => WebView(url:saleBox.moreUrl,                         
                        ),
                      ));                        
                  },
                  child: Text("获取更多福利>",style:TextStyle(color:Colors.white,fontSize:12)),

                ),
              ),  
            ],
          ),
        ),
        // 大卡片
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0,1),
        ),
        // 中间小卡片
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1,2),
        ),
        // 底部小卡片
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2,3),
        ),
      ],
    );
    
  }


  Widget _doubleItem(BuildContext context,CommonModel leftModel,CommonModel rightModel,bool isBig,bool isLast){

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _makeItem(context,leftModel,isBig,true,isLast),
          _makeItem(context,rightModel,isBig,false,isLast),
        ],
      );

  }

  Widget _makeItem(BuildContext context,CommonModel model,bool isBig,bool isLeft,bool isLast){

      // 使用 Expanded 撑开
      BorderSide borderSide = BorderSide(width: 0.8,color: Color(0xfff2f2f2));

      return GestureDetector(
        onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => WebView(url:"https://www.baidu.com/",
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar,
              ),
            ));
        },
        child: Container(

          // 设置卡片间的边框
            decoration: BoxDecoration(
              border: Border(
                right: isLeft?borderSide:BorderSide.none,
                bottom: isLast?BorderSide.none:borderSide,
              )
            ),
            child: Image.network(
              model.icon,
              width: MediaQuery.of(context).size.width / 2 - 10 - 8.8,
              height: isBig ? 129:80,
            ),
        )
      );
}


  // @required 标注参数是必须的
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        
      decoration: BoxDecoration(
        color: Colors.white,         
      ),
      child: Padding(padding: EdgeInsets.all(7),
          child: _items(context),
      ),
    );
    
  }

}
 
