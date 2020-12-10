class CommonModel {
  String _icon;
  String _title;
  String _url;
  String _statusBarColor;
  bool _hideAppBar;

  CommonModel(
      {String icon,
        String title,
        String url,
        String statusBarColor,
        bool hideAppBar}) {
    this._icon = icon;
    this._title = title;
    this._url = url;
    this._statusBarColor = statusBarColor;
    this._hideAppBar = hideAppBar;
  }

  String get icon => _icon;
  set icon(String icon) => _icon = icon;
  String get title => _title;
  set title(String title) => _title = title;
  String get url => _url;
  set url(String url) => _url = url;
  String get statusBarColor => _statusBarColor;
  set statusBarColor(String statusBarColor) => _statusBarColor = statusBarColor;
  bool get hideAppBar => _hideAppBar;
  set hideAppBar(bool hideAppBar) => _hideAppBar = hideAppBar;

  CommonModel.fromJson(Map<String, dynamic> json) {
    _icon = json['icon'];
    _title = json['title'];
    _url = json['url'];
    _statusBarColor = json['statusBarColor'];
    _hideAppBar = json['hideAppBar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this._icon;
    data['title'] = this._title;
    data['url'] = this._url;
    data['statusBarColor'] = this._statusBarColor;
    data['hideAppBar'] = this._hideAppBar;
    return data;
  }
}