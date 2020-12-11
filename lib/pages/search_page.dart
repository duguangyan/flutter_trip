import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/webview.dart';
const URL = 'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';
const TYPES = ['1','2','3'];
class SearchPage extends StatefulWidget{

  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage({Key key, this.hideLeft, this.searchUrl = URL, this.keyword, this.hint}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<SearchPage>{

  SearchModel searchModel;
  String keyword;



  final PageController _controller = PageController(
    initialPage: 0
  );

  String showText = 'get';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: <Widget>[
          _appBar(),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: searchModel?.data?.length??0,
                itemBuilder: (BuildContext context,int position){
                  return _item(position);
                },
              )
            ),
          ),
        ],
      )
    );
  }

  _onTextChange(String keyword){
    keyword = keyword;
    if(keyword.length == 0){
      setState(() {
        searchModel = null;
      });
      return;
    }

    String url = widget.searchUrl + keyword;

    SearchDao.fetch(url,keyword).then((SearchModel model) => {
      // 只有当前输入得内容和服务器端返回得内容一致才渲染
      if(model.keyword == keyword){
        setState((){
          searchModel = model;
        })
      }
    }).catchError((e){
      print(e);
    });

  }


  Widget _appBar(){
    return Column(
      children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff000000),Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
            child: Container(
              padding: EdgeInsets.only(top: 20),
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: SearchBar(
                searchBarType: SearchBarType.normol,
                hideLeft: widget.hideLeft,
                defaultText: widget.keyword,
                hint: widget.hint,
                leftButtonClick: (){
                  Navigator.pop(context);
                },
                onChanged: _onTextChange,
                rightButtonClick: (){
                  print('123');
                },
              ),
            ),
          )
      ],
    );
  }


  Widget _item(int position){
    if(searchModel == null || searchModel.data == null) return null;
    SearchItem item = searchModel.data[position];
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder:(context)=>WebView(
            url: item.url,
            title: item.word,
          )
        ));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.3,
              color: Colors.grey
            )
          )
        ),
        child:Row(
          children: <Widget>[

            Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(right: 20),
              color: Colors.black12,
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: Text('${item.word??''} ${item.districtname??''} ${item.zonename??''}'),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.fromLTRB(0,5,0,0),
                  child: Text('${item.price??''} ${item.type??''}',style: TextStyle(
                      color: Colors.orange
                  ),),
                )
              ],
            ),
          ],
        )
      ),
    );
  }



  _typeImage(String type){
    if(type == null) return 'imgaes/type_travelgroup.png';
    String path = 'travelgroup';
    for (final str in TYPES){
      if(type.contains(str)){
        path = str;
      }
    }
    return 'images/type_${path}.png';
  }

  _title(SearchItem item){
    // Text('${item.word??''} ${item.districtname??''} ${item.zonename??''}')
    if(item == null) return null;
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word,searchModel.keyword));
  }

  _subTitle(SearchItem item){
    if(item == null) return null;
    // Text('${item.price??''} ${item.type??''}',style: TextStyle(
    //                       color: Colors.red
    //                   ),),
  }

  _keywordTextSpans(String word, String keyword){
    List<TextSpan> spans = [];
    if(word == null || word.length == 0) return spans;

    List<String> arr = word.split(keyword);

    TextStyle normalStyle = TextStyle(fontSize: 16,color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16,color: Colors.orange);

    for(int i=0;i<arr.length;i++){
      if((i+1)/2 == 0){
        spans.add(TextSpan(text: keyword,style: keywordStyle));
      }
      String val = arr [i];
      if(val !=null && val.length>0){
        spans.add(TextSpan(text: val,style: normalStyle));
      }
    }
    return spans;
  }

}