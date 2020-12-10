import 'package:flutter_trip/model/common_model.dart';
/// 活动入口 model
class SalesBoxModel{

  final String icon;
  final String moreUrl;
  final CommonModel bigCard1;
  final CommonModel bigCard2;
  final CommonModel smallCard1;
  final CommonModel smallCard2;
  final CommonModel smallCard3;
  final CommonModel smallCard4;

  SalesBoxModel({this.icon, this.moreUrl, this.bigCard1, this.bigCard2, this.smallCard1, this.smallCard2, this.smallCard3, this.smallCard4});

  factory SalesBoxModel.fromJson(Map<String,dynamic> json){
    return json!= null ? SalesBoxModel(
      icon:json['icon'],
      moreUrl:json['moreUrl'],
      bigCard1:CommonModel.fromJson(json['bigCard1']),
      bigCard2:CommonModel.fromJson(json['bigCard2']),
      smallCard1:CommonModel.fromJson(json['smallCard1']),
      smallCard2:CommonModel.fromJson(json['smallCard2']),
      smallCard3:CommonModel.fromJson(json['smallCard3']),
      smallCard4:CommonModel.fromJson(json['smallCard4'])
    ):null;
  }

  // 转成json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['moreUrl'] = this.moreUrl;
    data['bigCard1'] = this.bigCard1.toJson();
    data['bigCard2'] = this.bigCard2.toJson();
    data['smallCard1'] = this.smallCard1.toJson();
    data['smallCard2'] = this.smallCard2.toJson();
    data['smallCard3'] = this.smallCard3.toJson();
    data['smallCard4'] = this.smallCard4.toJson();
    return data;
  }

}