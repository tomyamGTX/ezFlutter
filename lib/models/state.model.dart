class StateModel {
  Data? data;
  About? about;

  StateModel({this.data, this.about});

  StateModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    about = json['about'] != null ? About.fromJson(json['about']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (about != null) {
      data['about'] = about!.toJson();
    }
    return data;
  }
}

class Data {
  List<String>? negeri;

  Data({this.negeri});

  Data.fromJson(Map<String, dynamic> json) {
    negeri = json['negeri'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['negeri'] = negeri;
    return data;
  }
}

class About {
  String? github;
  String? source;
  String? createdBy;

  About({this.github, this.source, this.createdBy});

  About.fromJson(Map<String, dynamic> json) {
    github = json['github'];
    source = json['source'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['github'] = this.github;
    data['source'] = this.source;
    data['created_by'] = this.createdBy;
    return data;
  }
}
