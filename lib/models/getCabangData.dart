class DaftarCabang {
  String? sId;
  String? namaPengujian;
  String? deskripsi;
  List<Lokasi>? lokasi;
  int? iV;

  DaftarCabang(
      {this.sId, this.namaPengujian, this.deskripsi, this.lokasi, this.iV});

  DaftarCabang.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    namaPengujian = json['namaPengujian'];
    deskripsi = json['deskripsi'];
    if (json['lokasi'] != null) {
      lokasi = <Lokasi>[];
      json['lokasi'].forEach((v) {
        lokasi!.add(Lokasi.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['namaPengujian'] = namaPengujian;
    data['deskripsi'] = deskripsi;
    if (lokasi != null) {
      data['lokasi'] = lokasi!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}

class Lokasi {
  String? namaLokasi;
  int? luas;
  int? harga;
  int? kepadatanpenduduk;
  int? kantorterdekat;
  int? tokokueterdekat;
  double? score;
  int? ranking;
  String? sId;

  Lokasi(
      {this.namaLokasi,
      this.luas,
      this.harga,
      this.kepadatanpenduduk,
      this.kantorterdekat,
      this.tokokueterdekat,
      this.score,
      this.ranking,
      this.sId});

  Lokasi.fromJson(Map<String, dynamic> json) {
    namaLokasi = json['namaLokasi'];
    luas = json['luas'];
    harga = json['harga'];
    kepadatanpenduduk = json['kepadatanpenduduk'];
    kantorterdekat = json['kantorterdekat'];
    tokokueterdekat = json['tokokueterdekat'];
    score = json['score'];
    ranking = json['ranking'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['namaLokasi'] = namaLokasi;
    data['luas'] = luas;
    data['harga'] = harga;
    data['kepadatanpenduduk'] = kepadatanpenduduk;
    data['kantorterdekat'] = kantorterdekat;
    data['tokokueterdekat'] = tokokueterdekat;
    data['score'] = score;
    data['ranking'] = ranking;
    data['_id'] = sId;
    return data;
  }
}
