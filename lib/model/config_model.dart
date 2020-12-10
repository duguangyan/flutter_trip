class ConfigModel {
  String _searchUrl;

  ConfigModel({String searchUrl}) {
    this._searchUrl = searchUrl;
  }

  String get searchUrl => _searchUrl;
  set searchUrl(String searchUrl) => _searchUrl = searchUrl;

  ConfigModel.fromJson(Map<String, dynamic> json) {
    _searchUrl = json['searchUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchUrl'] = this._searchUrl;
    return data;
  }
}