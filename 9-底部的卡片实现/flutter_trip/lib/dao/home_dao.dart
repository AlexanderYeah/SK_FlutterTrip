import 'package:flutter_trip/model/home_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; 

const HOME_URL = "http://www.devio.org/io/flutter_app/json/home_page.json";

// 首页的接口返回的数据

class HomeDao{
  static Future<HomeModel> fetch() async {
      final response  = await http.get(HOME_URL);      
      if (response.statusCode == 200){
        
        // 请求成功 中文解码用utf8
        Utf8Decoder utf8decoder  = Utf8Decoder();
        var result = json.decode(utf8decoder.convert(response.bodyBytes));
        return HomeModel.fromJson(result);
      }else{
        // 请求失败        
        throw Exception("failed load home page json data");
      }
  } 
}