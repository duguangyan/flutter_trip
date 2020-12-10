import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/webview.dart';
const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<HomePage> {

  final PageController _controller = PageController(initialPage: 0);

  // 透明度
  double appBarAlpha = 0;

  // 进度条
  bool _isLoading = false;
  bool _cover = true;

  // 请求home_page数据
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  List<CommonModel> bannerList = [];

  SalesBoxModel salesBox;
  GridNavModel gridNavModel;

  @override
  void initState(){
    super.initState();
    // 加载数据
    _isLoading = true;
    _handleonRefresh();
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
  Future<Null> _handleonRefresh() async{
    try{
      HomeModel model = await HomeDao.fetch();
      setState(() {
        subNavList   = model.subNavList;
        localNavList = model.localNavList;
        bannerList   = model.bannerList;
        gridNavModel = model.gridNav;
        salesBox     = model.salesBox;
        _isLoading = false;
      });
    } catch (e){
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
        isLoading: _isLoading,
        child: Scaffold(
            backgroundColor: Color(0xfff2f2fa),
            body: Stack(
              children: <Widget>[
                MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: RefreshIndicator(
                      onRefresh: _handleonRefresh,
                      child: NotificationListener(
                        // ignore: missing_return
                        onNotification: (scrollNotification){
                          if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0){
                            _inScroll(scrollNotification.metrics.pixels);
                          }
                        },
                        child: _listView,
                      ),
                    )
                ),
                _appBar
              ],
            )
        )
    );
  }

  Widget get _appBar {
    return Opacity(
      opacity: appBarAlpha,
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.black),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('首页',style: TextStyle(
                fontSize: 24.0,
                color: Colors.white
            ),),
          ),
        ),
      ),
    );
  }

  Widget get _listView{
    return ListView(
      children: <Widget>[
        Container(
          height: 160,
          child: _swiper,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7,4,7,4),
          child: LocalNav(localNavList:localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7,0,7,4),
          child: GridNav(gridNavModel: gridNavModel,),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7,0,7,4),
          child: SubNav(subNavList: subNavList,),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7,0,7,4),
          child: SalesBox(salesBox: salesBox),
        ),
        // Container(
        //   height: 800,
        //   child: ListTile(
        //     title: Text('resultString'),
        //   ),
        // )
      ],
    );
  }

  Widget get _swiper {
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(
                builder: (context)=>WebView(
                    url: bannerList[index].url
                )
            ));
          },
          child: Image.network(
            bannerList[index].icon,
            fit: BoxFit.fill,
          ),
        );
      },
      pagination: SwiperPagination(),
      // control: SwiperControl(),
      // viewportFraction: 0.8,
      // scale: 0.9,
      onTap: (index) {
        print(index);
      },
    );
  }

}
