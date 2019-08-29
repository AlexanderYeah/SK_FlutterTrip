import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
 
// https://pub.dev/packages/flutter_webview_plugin 插件地址
class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  const WebView(
      {Key key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid})
      : super(key: key);

  // @required 标注参数是必须的
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {

  final webviewReference = new FlutterWebviewPlugin();
  StreamSubscription<String>  _onChanged;
  StreamSubscription<WebViewStateChanged>  _onStateChanged;
  StreamSubscription<WebViewHttpError> _onErrorChanged;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webviewReference.close();
    // 进行监听URL 变化 
    _onChanged = webviewReference.onUrlChanged.listen((String url){});

         // 监听状态的变化 
    _onStateChanged = webviewReference.onStateChanged.listen((WebViewStateChanged state){
       switch (state.type) {
         case WebViewState.startLoad:
           
           break;
         default:
       }
    });
    // 错误的监听
    _onErrorChanged = webviewReference.onHttpError.listen((WebViewHttpError error){
      print(error);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // 取消监听
    _onChanged.cancel();
    _onErrorChanged.cancel();
    _onStateChanged.cancel();
    // 销毁
    webviewReference.dispose();
    // 页面状态发生变化
  } 

  _appBar(Color bgColor,Color btnColor){
      // 如果是隐藏Appbar
      if(widget.hideAppBar??false){
        return Container(
          color: bgColor,
          height: 30,
        );
      }
      // 如果是不隐藏的操作
      return Container(
        // FractionallySizedBox 让其撑满屏幕
        child: FractionallySizedBox(
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Icon(
                      Icons.close,
                      color: btnColor,
                      size: 26,
                    ),
                  ),
                ),
                // 绝对定位 
                Positioned(
                  left: 0,
                  right: 0, 
                  child: Center(
                    child: Text(widget.title,
                    style:TextStyle(color: btnColor,fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
        ),
      );

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    String statusBarColor = widget.statusBarColor ?? "ffffff";
    Color backBtnColor;
    if (statusBarColor == "ffffff"){
      backBtnColor = Colors.black;
    }else{
      backBtnColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse("0xff"+statusBarColor)),backBtnColor),
          // 撑满屏幕
          Expanded(child: WebviewScaffold(url: widget.url, 
          // 是否可以缩放
          withZoom:true,
          // 是否启动本地存储 
          withLocalStorage: true,
          // 是否隐藏
          hidden: true,
          // 当界面未加载出来之前 显示一个等待的界面
          initialChild: Container(
            color: Colors.white,
            child: Center(
              child: Text('加载中'),
            ),
          ),
          ),           
          ),
        ], 
      ),
    );
  }
}
