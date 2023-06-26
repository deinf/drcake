class AddLokasiModel {
  String? apikey;
  String? namaPengujian;
  String? deskripsi;
  List<Lokasi>? lokasi;

  AddLokasiModel(
      {this.apikey, this.namaPengujian, this.deskripsi, this.lokasi});

  AddLokasiModel.fromJson(Map<String, dynamic> json) {
    apikey = json['apikey'];
    namaPengujian = json['namaPengujian'];
    deskripsi = json['deskripsi'];
    if (json['lokasi'] != null) {
      lokasi = <Lokasi>[];
      json['lokasi'].forEach((v) {
        lokasi!.add(new Lokasi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apikey'] = this.apikey;
    data['namaPengujian'] = this.namaPengujian;
    data['deskripsi'] = this.deskripsi;
    if (this.lokasi != null) {
      data['lokasi'] = this.lokasi!.map((v) => v.toJson()).toList();
    }
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

  Lokasi(
      {this.namaLokasi,
      this.luas,
      this.harga,
      this.kepadatanpenduduk,
      this.kantorterdekat,
      this.tokokueterdekat});

  Lokasi.fromJson(Map<String, dynamic> json) {
    namaLokasi = json['namaLokasi'];
    luas = json['luas'];
    harga = json['harga'];
    kepadatanpenduduk = json['kepadatanpenduduk'];
    kantorterdekat = json['kantorterdekat'];
    tokokueterdekat = json['tokokueterdekat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['namaLokasi'] = this.namaLokasi;
    data['luas'] = this.luas;
    data['harga'] = this.harga;
    data['kepadatanpenduduk'] = this.kepadatanpenduduk;
    data['kantorterdekat'] = this.kantorterdekat;
    data['tokokueterdekat'] = this.tokokueterdekat;
    return data;
  }
}
