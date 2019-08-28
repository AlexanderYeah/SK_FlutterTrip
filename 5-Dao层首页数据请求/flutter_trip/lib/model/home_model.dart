

import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sale_box_model.dart';
 

class HomeModel
{
  final  ConfigModel config;
  final List<CommonModel> bannerList;
  List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;
  HomeModel({this.config,this.bannerList,this.localNavList,this.gridNav,this.salesBox,this.subNavList});  

  factory HomeModel.fromJson(Map<String,dynamic> json){
    var resLocalNavList = json["localNavList"] as List;
    List<CommonModel> localNavList = resLocalNavList.map((i) => CommonModel.fromJson(i)).toList();

    var resBannerList = json["bannerList"] as List;
    List<CommonModel> bannerList = resBannerList.map((i) => CommonModel.fromJson(i)).toList();

    var resSubNavList = json["subNavList"] as List;
    List<CommonModel> subNavList = resSubNavList.map((i) => CommonModel.fromJson(i)).toList();

    
    return HomeModel(
      config:ConfigModel.fromJson(json["config"]),
      gridNav:GridNavModel.fromJson(json["gridNav"]),
      salesBox: SalesBoxModel.fromJson(json["salesBox"]),
      localNavList: localNavList,
      subNavList: subNavList,
      bannerList: bannerList,
    );

  }

}