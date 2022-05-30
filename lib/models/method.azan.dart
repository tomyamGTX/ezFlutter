class Method {
  var code;
  String? status;
  Data? data;

  Method({this.code, this.status, this.data});

  Method.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  MWL? mWL;
  MWL? iSNA;
  MWL? eGYPT;
  MWL? mAKKAH;
  MWL? kARACHI;
  MWL? tEHRAN;
  MWL? jAFARI;
  MWL? gULF;
  MWL? kUWAIT;
  MWL? qATAR;
  MWL? sINGAPORE;
  MWL? fRANCE;
  MWL? tURKEY;
  MWL? rUSSIA;
  MOONSIGHTING? mOONSIGHTING;
  CUSTOM? cUSTOM;

  Data(
      {this.mWL,
        this.iSNA,
        this.eGYPT,
        this.mAKKAH,
        this.kARACHI,
        this.tEHRAN,
        this.jAFARI,
        this.gULF,
        this.kUWAIT,
        this.qATAR,
        this.sINGAPORE,
        this.fRANCE,
        this.tURKEY,
        this.rUSSIA,
        this.mOONSIGHTING,
        this.cUSTOM});

  Data.fromJson(Map<String, dynamic> json) {
    mWL = json['MWL'] != null ? new MWL.fromJson(json['MWL']) : null;
    iSNA = json['ISNA'] != null ? new MWL.fromJson(json['ISNA']) : null;
    eGYPT = json['EGYPT'] != null ? new MWL.fromJson(json['EGYPT']) : null;
    mAKKAH = json['MAKKAH'] != null ? new MWL.fromJson(json['MAKKAH']) : null;
    kARACHI =
    json['KARACHI'] != null ? new MWL.fromJson(json['KARACHI']) : null;
    tEHRAN = json['TEHRAN'] != null ? new MWL.fromJson(json['TEHRAN']) : null;
    jAFARI = json['JAFARI'] != null ? new MWL.fromJson(json['JAFARI']) : null;
    gULF = json['GULF'] != null ? new MWL.fromJson(json['GULF']) : null;
    kUWAIT = json['KUWAIT'] != null ? new MWL.fromJson(json['KUWAIT']) : null;
    qATAR = json['QATAR'] != null ? new MWL.fromJson(json['QATAR']) : null;
    sINGAPORE =
    json['SINGAPORE'] != null ? new MWL.fromJson(json['SINGAPORE']) : null;
    fRANCE = json['FRANCE'] != null ? new MWL.fromJson(json['FRANCE']) : null;
    tURKEY = json['TURKEY'] != null ? new MWL.fromJson(json['TURKEY']) : null;
    rUSSIA = json['RUSSIA'] != null ? new MWL.fromJson(json['RUSSIA']) : null;
    mOONSIGHTING = json['MOONSIGHTING'] != null
        ? new MOONSIGHTING.fromJson(json['MOONSIGHTING'])
        : null;
    cUSTOM =
    json['CUSTOM'] != null ? new CUSTOM.fromJson(json['CUSTOM']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mWL != null) {
      data['MWL'] = this.mWL!.toJson();
    }
    if (this.iSNA != null) {
      data['ISNA'] = this.iSNA!.toJson();
    }
    if (this.eGYPT != null) {
      data['EGYPT'] = this.eGYPT!.toJson();
    }
    if (this.mAKKAH != null) {
      data['MAKKAH'] = this.mAKKAH!.toJson();
    }
    if (this.kARACHI != null) {
      data['KARACHI'] = this.kARACHI!.toJson();
    }
    if (this.tEHRAN != null) {
      data['TEHRAN'] = this.tEHRAN!.toJson();
    }
    if (this.jAFARI != null) {
      data['JAFARI'] = this.jAFARI!.toJson();
    }
    if (this.gULF != null) {
      data['GULF'] = this.gULF!.toJson();
    }
    if (this.kUWAIT != null) {
      data['KUWAIT'] = this.kUWAIT!.toJson();
    }
    if (this.qATAR != null) {
      data['QATAR'] = this.qATAR!.toJson();
    }
    if (this.sINGAPORE != null) {
      data['SINGAPORE'] = this.sINGAPORE!.toJson();
    }
    if (this.fRANCE != null) {
      data['FRANCE'] = this.fRANCE!.toJson();
    }
    if (this.tURKEY != null) {
      data['TURKEY'] = this.tURKEY!.toJson();
    }
    if (this.rUSSIA != null) {
      data['RUSSIA'] = this.rUSSIA!.toJson();
    }
    if (this.mOONSIGHTING != null) {
      data['MOONSIGHTING'] = this.mOONSIGHTING!.toJson();
    }
    if (this.cUSTOM != null) {
      data['CUSTOM'] = this.cUSTOM!.toJson();
    }
    return data;
  }
}

class MWL {
  var id;
  String? name;
  Params? params;
  Location? location;

  MWL({this.id, this.name, this.params, this.location});

  MWL.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    params =
    json['params'] != null ? new Params.fromJson(json['params']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.params != null) {
      data['params'] = this.params!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Params1 {
  var fajr;
  var isha;

  Params1({this.fajr, this.isha});

  Params1.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    isha = json['Isha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fajr'] = this.fajr;
    data['Isha'] = this.isha;
    return data;
  }
}

class Location {
  var latitude;
  var longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Params {
  var fajr;
  var isha;

  Params({this.fajr, this.isha});

  Params.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    isha = json['Isha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fajr'] = this.fajr;
    data['Isha'] = this.isha;
    return data;
  }
}

class Params2 {
  var fajr;
  String? isha;

  Params2({this.fajr, this.isha});

  Params2.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    isha = json['Isha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fajr'] = this.fajr;
    data['Isha'] = this.isha;
    return data;
  }
}

class Params3 {
  var fajr;
  var isha;
  var maghrib;
  String? midnight;

  Params3({this.fajr, this.isha, this.maghrib, this.midnight});

  Params3.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    isha = json['Isha'];
    maghrib = json['Maghrib'];
    midnight = json['Midnight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fajr'] = this.fajr;
    data['Isha'] = this.isha;
    data['Maghrib'] = this.maghrib;
    data['Midnight'] = this.midnight;
    return data;
  }
}

class Params4 {
  var fajr;
  var isha;
  var maghrib;
  String? midnight;

  Params4({this.fajr, this.isha, this.maghrib, this.midnight});

  Params4.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    isha = json['Isha'];
    maghrib = json['Maghrib'];
    midnight = json['Midnight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fajr'] = this.fajr;
    data['Isha'] = this.isha;
    data['Maghrib'] = this.maghrib;
    data['Midnight'] = this.midnight;
    return data;
  }
}

class Params5 {
  var fajr;
  var isha;

  Params5({this.fajr, this.isha});

  Params5.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    isha = json['Isha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fajr'] = this.fajr;
    data['Isha'] = this.isha;
    return data;
  }
}

class Params6 {
  var fajr;
  String? isha;

  Params6({this.fajr, this.isha});

  Params6.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    isha = json['Isha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fajr'] = this.fajr;
    data['Isha'] = this.isha;
    return data;
  }
}

class MOONSIGHTING {
  var id;
  String? name;
  Params? params;

  MOONSIGHTING({this.id, this.name, this.params});

  MOONSIGHTING.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    params =
    json['params'] != null ? new Params.fromJson(json['params']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.params != null) {
      data['params'] = this.params!.toJson();
    }
    return data;
  }
}

class Params7 {
  String? shafaq;

  Params7({this.shafaq});

  Params7.fromJson(Map<String, dynamic> json) {
    shafaq = json['shafaq'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shafaq'] = this.shafaq;
    return data;
  }
}

class CUSTOM {
  var id;

  CUSTOM({this.id});

  CUSTOM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
