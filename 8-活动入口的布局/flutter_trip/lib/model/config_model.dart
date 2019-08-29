import 'dart:convert';

class ConfigModel
{
   final String searchUrl;
   // 构造方法
   ConfigModel({this.searchUrl});

   factory  ConfigModel.fromJson(Map<String,dynamic> json){     
     return ConfigModel(searchUrl: json['searchUrl']);
   }

    // 反序列化方法
    Map<String,dynamic> toJson(){
      return {"searchUrl":searchUrl};
    }



}