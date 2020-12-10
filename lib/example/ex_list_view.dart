import 'package:flutter/material.dart';

const CITY_NAMES = ['广州','上海','深圳','广州','上海','深圳','广州','上海','深圳','广州','上海','深圳'];


class ExListView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _buildList(),
      ),
    );
  }
}

List<Widget> _buildList(){
  return CITY_NAMES.map((city)=>_item(city)).toList();
}

Widget _item(String city){
  return Container(
      height: 20,
      width: 100,
      margin: EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white,fontSize: 20),
      )
  );
}