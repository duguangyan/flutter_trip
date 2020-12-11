/// 搜索实体类

class SearchModel {

  final List<SearchItem> data;

  String keyword;

  SearchModel({this.data,this.keyword});

  factory SearchModel.fromJson(Map<String,dynamic> json){
    var datajson = json['data'] as List;

    List<SearchItem> data =  datajson.map((i) => SearchItem.fromJson(i)).toList();

    return SearchModel(data:data);
  }

  // 转成json
  List toJson() {
    final List data = new List<SearchItem>();
    this.data.forEach((i) => {
      data.add(i.toJson())
    });
    return data;
  }

}

class SearchItem {

  final String word; // xx酒店
  final String type; // hotel
  final String price; //实时计价
  final String star; // 豪华型
  final String zonename; //虹桥
  final String districtname; //上海
  final String url;

  SearchItem({this.word, this.type, this.price, this.star, this.zonename,this.districtname, this.url});

  factory SearchItem.fromJson(Map<String,dynamic> json){
    return SearchItem(
      word:json['word'],
      type:json['type'],
      price:json['price'],
      star:json['star'],
      zonename:json['zonename'],
      districtname:json['districtname'],
      url:json['url'],
    );
  }

  // 转成json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    data['type'] = this.type;
    data['price'] = this.price;
    data['star'] = this.star;
    data['zonename'] = this.zonename;
    data['districtname'] = this.districtname;
    data['url'] = this.url;
    return data;
  }


}