import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widget/webview.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class SubNav extends StatelessWidget {

  final List<CommonModel> subNavList;

  const SubNav({Key key, @required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 148,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if(subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((model){
      items.add(_item(context,model));
    });
    int separate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0,separate),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate,subNavList.length),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context,CommonModel model){
     return Expanded(
       flex: 1,
       child: GestureDetector(
         onTap: (){
           Navigator.push(context, MaterialPageRoute(
               builder: (context)=>
                   WebView(url: model.url, statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar)
           ));

         },
         child: Column(
           mainAxisAlignment:MainAxisAlignment.spaceAround,
           children: <Widget>[
             Image.network(
               model.icon,
               width: 32,
               height: 32,
             ),
             Padding(
               padding: EdgeInsets.only(top: 10),
               child: Text(
                 model.title,
                 style: TextStyle(
                   fontSize: 12,
                 ),
               ),
             )
           ],
         ),
       ),
     );
  }
}