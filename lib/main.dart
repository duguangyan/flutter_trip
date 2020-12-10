import 'package:flutter/material.dart';
import 'package:flutter_trip/navigator/tab_navigator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'example/ex_grid_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{

  @override
  _MyAppState createState()=>_MyAppState();

}
class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 此处假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
        ScreenUtil.init(constraints, designSize: Size(750, 1334), allowFontScaling: false);

        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            //home:TabNavigator(),
            home:Scaffold(
              // appBar: AppBar(
              //   title: Text('title'),
              // ),
                body: TabNavigator()
            )
        );
      },
    );
  }
}