import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SearchBarType { home , normol, homeLight }

class SearchBar extends StatefulWidget{

  final bool enabled = true;
  final bool hideLeft;
  final SearchBarType searchBarType;
  final String hint;
  final String defaultText;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speackClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onChanged;

  const SearchBar({Key key, this.hideLeft, this.hint, this.defaultText, this.leftButtonClick, this.rightButtonClick, this.speackClick, this.inputBoxClick, this.onChanged, this.searchBarType}) : super(key: key);



  @override
  _SearchBarState createState() => _SearchBarState();

}

class _SearchBarState extends State<SearchBar>{

  bool showClear = false;

  final TextEditingController _controller = TextEditingController();


  @override
  void initState(){


    /// 返回时,带回参数
    if(widget.defaultText!=null){
      setState(() {
        _controller.text = widget.defaultText;
      });
    }

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normol
    ? _genNormolSearch() : _genHomeSearch();
  }


  Widget _genNormolSearch(){
    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      margin: EdgeInsets.only(top: 4),
      child: Row(
        children: <Widget>[
          _warpTap(
            Container(
              child: widget?.hideLeft??false?null:Icon(Icons.arrow_back_ios),
            ),
            widget.leftButtonClick
          ),
          Expanded(
            flex: 1,
            child: _inputCheck(),
          ),
          _warpTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 10, 5),
                child: Text('搜索',style: TextStyle(
                  color: Colors.blue,
                  fontSize: 17
                ),),
              ),
              widget.rightButtonClick
          )
        ],
      ),
    );
  }

  Widget _genHomeSearch(){
    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: <Widget>[
          _warpTap(
              Container(
                margin: EdgeInsets.only(right: 5),
                child: Row(
                  children: <Widget>[
                    Text('上海',style: TextStyle(
                      color: _homeFontColor(),
                      fontSize: 20
                    ),),
                    Icon(
                      Icons.expand_more,
                      color: _homeFontColor(),
                      size: 22,
                    )
                  ],
                ),
              ),
              widget.leftButtonClick
          ),
          Expanded(
            flex: 1,
            child: _inputCheck(),
          ),
          _warpTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(Icons.comment,
                color: _homeFontColor(),
                size: 26)
              ),
              widget.rightButtonClick
          )
        ],
      ),
    );
  }


  Widget _warpTap(Widget child,void Function() callBack){
    return GestureDetector(
      onTap:(){
        if(callBack!=null)callBack();
      },
      child: child,
    );
  }


  Widget _inputCheck(){

    Color inputBoxColor;
    if(widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    }else{
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(widget.searchBarType == SearchBarType.normol?10:30)
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.search,
              size: 20,
              color: widget.searchBarType == SearchBarType.normol
                  ? Color(0xffA9A9A9):Colors.blue,
            ),
          ),
          Expanded(
            flex: 1,
            child: widget.searchBarType == SearchBarType.normol?
            Container(
              margin: EdgeInsets.only(top: 30),
              child: TextField(
                controller: _controller,
                onChanged: _onChanged,
                autofocus: true,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w300
                ),
                decoration: InputDecoration(
                  // contentPadding: EdgeInsets.all(0),
                    border: InputBorder.none,
                    hintText: widget.hint??'',
                    hintStyle: TextStyle(fontSize: 15)
                ),
              ),
            ):_warpTap(
              Container(
                child: Text(widget.defaultText,style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey
                ),),
              ),
              widget.inputBoxClick
            )
          ),
          !showClear?_warpTap(
              Icon(Icons.mic,size: 22,color: widget.searchBarType==SearchBarType.normol?Colors.blue:Colors.grey),
              widget.speackClick
          ):_warpTap(Icon(Icons.clear,size: 22,color: Colors.grey,),(){
            setState(() {
              _controller.clear();
            });
            _onChanged('');
          })
        ],
      ),
    );
  }

  /// 搜索栏数据onChange
  _onChanged(String text){
    if(text.length > 0){
      setState(() {
        showClear = true;
      });
    }else{
      setState(() {
        showClear = false;
      });
    }
    if(widget.onChanged!=null){
      widget.onChanged(text);
    }
  }

  //  获取首页前景色
  _homeFontColor(){
    return widget.searchBarType == SearchBarType.home? Colors.white:Colors.black45;
  }

}
