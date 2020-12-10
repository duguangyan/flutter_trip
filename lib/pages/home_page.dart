import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/local_nav.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<HomePage> {

  final PageController _controller = PageController(initialPage: 0);

  // 轮播图片
  List _imageUrls = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ];

  // 透明度
  double appBarAlpha = 0;

  // 请求home_page数据
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;

  @override
  void initState(){
    super.initState();
    // 加载数据
    loadData();
  }

  // 滚动监听
  void _inScroll(offset){
      print(offset);
      double alpha = offset / APPBAR_SCROLL_OFFSET;
      if(alpha<0) {
        alpha = 0;
      } else if(alpha >1){
        alpha = 1;
      }
      setState(() {
        appBarAlpha = alpha;
      });
  }
  // 加载数据
  loadData() async{
    try{
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
      });
    } catch (e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2fa),
        body: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: NotificationListener(
                  // ignore: missing_return
                  onNotification: (scrollNotification){
                    if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0){
                      _inScroll(scrollNotification.metrics.pixels);
                    }
                  },
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 160.0,
                        child: Swiper(
                          itemCount: _imageUrls.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              _imageUrls[index],
                              fit: BoxFit.fill,
                            );
                          },
                          pagination: SwiperPagination(),
                          // control: SwiperControl(),
                          // viewportFraction: 0.8,
                          // scale: 0.9,
                          onTap: (index) {
                            print(index);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7,4,7,4),
                        child: LocalNav(localNavList:localNavList),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7,4,7,4),
                        child: GridNav(gridNavModel: gridNavModel,),
                      ),
                      Container(
                        height: 800,
                        child: ListTile(
                          title: Text('resultString'),
                        ),
                      )
                    ],
                  ),
                )
            ),
            Opacity(
              opacity: appBarAlpha,
              child: Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text('首页',style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.lightBlue
                    ),),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}