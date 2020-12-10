import 'package:flutter/material.dart';

const CITY_MAMES = ['上海','上海','上海','上海','上海','上海'];

class ExGridView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GridView.count(
        crossAxisCount: 2,
        children: _buildList(),
      ),
    );
  }
}


List<Widget> _buildList(){
  return CITY_MAMES.map((city) => _item(city)).toList();
}


Widget _item(city){
  return Container(
    height: 80,
    margin: EdgeInsets.all(5),
    alignment: Alignment.center,
    decoration: BoxDecoration(color: Colors.teal),
    child: Text(
      city,
      style: TextStyle(
        fontSize: 20
      ),
    ),
  );
}