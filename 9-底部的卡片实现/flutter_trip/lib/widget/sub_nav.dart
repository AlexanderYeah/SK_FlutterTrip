import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class SubNav extends StatelessWidget{
  
  final List<CommonModel> subNavList;
  // final 
  const SubNav({Key key,@required this.subNavList}) : super(key:key);

  _items(BuildContext context){
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((model) {
        items.add(_makeItem(context,model));
    });
    // 将数据一分为二
    int seperate = ((subNavList.length / 2) + 0.5).toInt();

    //
    return Column(
      children: <Widget>[
        Row(
        // 平均排列
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.sublist(0,seperate),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(seperate,subNavList.length),
          ),
        )
      ],
    );
    
  }

  Widget _makeItem(BuildContext context,CommonModel model){

      // 使用 Expanded 撑开
      return Expanded(
        flex: 1,
        child: GestureDetector(
        onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => WebView(url:"https://www.baidu.com/",
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar,
              ),
            ));
        },
        child: Column(
          children: <Widget>[
            Image.network(
              model.icon,
              width: 18,
              height: 18,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3),
              child:  Text(model.title,
              style:TextStyle(fontSize:12)),

            )
          ],
        ),
      ),
    );
  }


  // @required 标注参数是必须的
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 128,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: Padding(padding: EdgeInsets.all(7),
          child: _items(context),
      ),
    );
    
  }

}
 
