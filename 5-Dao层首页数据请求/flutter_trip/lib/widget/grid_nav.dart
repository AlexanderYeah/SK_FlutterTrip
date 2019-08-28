import 'package:flutter/material.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';

class GridNav extends StatefulWidget{

  // final 
  final GridNavModel gridNavModel;

  // @required 标注参数是必须的
  GridNav({Key key, @required this.gridNavModel}) : super(key:key);
  _GridnavState createState() => _GridnavState();

}

class _GridnavState extends State<GridNav>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }


  
}