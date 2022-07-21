class ZoneModel {
  Data? data;
  About? about;

  ZoneModel({this.data, this.about});

  ZoneModel.fromJson(Map<String, dynamic> json) {
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
  Negeri? negeri;

  Data({this.negeri});

  Data.fromJson(Map<String, dynamic> json) {
    negeri = json['negeri'] != null ? Negeri.fromJson(json['negeri']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (negeri != null) {
      data['negeri'] = negeri!.toJson();
    }
    return data;
  }
}

class Negeri {
  String? nama;
  List<String>? zon;

  Negeri({this.nama, this.zon});

  Negeri.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    zon = json['zon'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['zon'] = zon;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['github'] = github;
    data['source'] = source;
    data['created_by'] = createdBy;
    return data;
  }
}
