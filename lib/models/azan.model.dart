class AzanModel {
  List<Data>? data;
  About? about;

  AzanModel({this.data, this.about});

  AzanModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    about = json['about'] != null ? new About.fromJson(json['about']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.about != null) {
      data['about'] = this.about!.toJson();
    }
    return data;
  }
}

class Data {
  String? negeri;
  String? zon;
  List<WaktuSolat>? waktuSolat;

  Data({this.negeri, this.zon, this.waktuSolat});

  Data.fromJson(Map<String, dynamic> json) {
    negeri = json['negeri'];
    zon = json['zon'];
    if (json['waktu_solat'] != null) {
      waktuSolat = <WaktuSolat>[];
      json['waktu_solat'].forEach((v) {
        waktuSolat!.add(new WaktuSolat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['negeri'] = this.negeri;
    data['zon'] = this.zon;
    if (this.waktuSolat != null) {
      data['waktu_solat'] = this.waktuSolat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WaktuSolat {
  String? name;
  String? time;

  WaktuSolat({this.name, this.time});

  WaktuSolat.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['time'] = this.time;
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
