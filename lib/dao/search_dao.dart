import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchDao{
  static Future<SearchModel> fetch(String url,String keyword) async{
    final response = await http.get(url);
    if(response.statusCode == 200) {
        Utf8Decoder utf8Decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8Decoder.convert(response.bodyBytes));
      // 只有当前输入得内容和服务器端返回得内容一致才渲染
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = keyword;
      return model;
    }else{
      throw Exception('Failed to laod home_page.json');
    }
  }
}