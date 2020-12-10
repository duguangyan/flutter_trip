import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// 加载进度条组件
class LoadingContainer extends StatelessWidget {

  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer({Key key, @required this.isLoading, this.cover=false,@required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover?(!isLoading? child: _loadView):Stack(
      children: [child,isLoading?_loadView:null],
    );
  }

  Widget get _loadView{
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  
}