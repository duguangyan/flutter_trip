import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

/// 首页 model
class HomeModel{

  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel( {this.config,this.bannerList,this.localNavList,this.subNavList,this.gridNav,this.salesBox});

  factory HomeModel.fromJson(Map<String,dynamic> json){

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList = localNavListJson.map((i) => CommonModel.fromJson(i)).toList();
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList = bannerListJson.map((i) => CommonModel.fromJson(i)).toList();
    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList = subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return json!=null? HomeModel(
      localNavList: localNavList,
      bannerList: bannerList,
      subNavList: subNavList,
      config: ConfigModel.fromJson(json['config']),
      gridNav:GridNavModel.fromJson(json['gridNav']),
      salesBox:SalesBoxModel.fromJson(json['salesBox']),
    ):null;
  }

  // 转成json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['config'] = this.config.toJson();
    data['bannerList'] = this.bannerList.toList();
    data['localNavList'] = this.localNavList.toList();
    data['subNavList'] = this.subNavList.toList();
    data['gridNav'] = this.gridNav.toJson();
    data['salesBox'] = this.salesBox.toJson();
    return data;
  }

}