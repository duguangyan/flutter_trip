import 'package:flutter/material.dart';

const CITY_NAMES = {
  '北京':['1','2','3','4'],
  '上海':['1','2','3','4'],
  '广州':['1','2','3','4'],
  '杭州':['1','2','3','4'],
  '苏州':['1','2','3','4'],
  '日本':['1','2','3','4']
};
class ExExpanisionTile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: _buildList())
    );
  }
}

List<Widget> _buildList(){
  List<Widget> widgets = [];

  CITY_NAMES.keys.forEach((key) {
    widgets.add(_item(key,CITY_NAMES[key]));
  });
  return widgets;
}

Widget _item(String city, List<String> subCities){
  return ExpansionTile(
    title: Text(
      city,
      style: TextStyle(color: Colors.black45,fontSize: 30),
    ),
    children: subCities.map((subCity) => _buildSub(subCity)).toList(),
  );
}


Widget _buildSub(String subCity){
  return FractionallySizedBox(
    widthFactor: 1,
    child: Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(color: Colors.lightBlueAccent),
      child: Text(subCity)
    ),
  );
}

