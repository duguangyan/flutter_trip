import 'package:flutter/material.dart';


List<String> cityNames = ['上海1','上海2','上海3','上海4','上海','上海','上海','上海','上海','上海','上海','上海','上海','上海10'];

class ExRefresIndicator extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _hanleRefesh,
      child: ListView(
        children: _buildList(),
      ),
    );
  }
}

Future<Null> _hanleRefesh() async{
  await Future.delayed(Duration(seconds: 2));
  // setState((){
  //   cityNames = cityNames.reversed.toList();
  // });
  print('RefreshIndicator');
  return null;
}



List<Widget> _buildList(){
  return cityNames.map((city) => _item(city)).toList();
}


Widget _item(String city){
  return Container(
    height: 80,
    child: Text(city),
  );
}
