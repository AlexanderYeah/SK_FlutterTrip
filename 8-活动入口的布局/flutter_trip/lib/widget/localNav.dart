import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class LocalNav extends StatelessWidget{
  
  final List<CommonModel> localNavList;
  // final 
  const LocalNav({Key key,@required this.localNavList}) : super(key:key);

  _items(BuildContext context){
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList.forEach((model) {
        items.add(_makeItem(context,model));
    });

    //
    return Row(
        // 平均排列
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
    );
    
  }

  Widget _makeItem(BuildContext context,CommonModel model){

      return GestureDetector(
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
              width: 32,
              height: 32,
            ),
            Text(model.title,
            style:TextStyle(fontSize:12)),
          ],
        ),
      );
  }


  // @required 标注参数是必须的
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 64,
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
 