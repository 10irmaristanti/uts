class Kategori {
  int _id;
  String _kategoriProduk;
  String _keterangan;

  int get id => _id;

  String get kategoriProduk => this._kategoriProduk;
  set kategoriProduk(String value) => this._kategoriProduk = value;

  String get keterangan => this._keterangan;
  set keterangan(String value) => this._keterangan = value;

  // konstruktor versi 1
  Kategori(this._kategoriProduk, this._keterangan);

  // konstruktor versi 2: konversi dari Map ke Item
  Kategori.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._kategoriProduk = map['kategoriProduk'];
    this._keterangan = map['keterangan'];
  }

  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['kategoriProduk'] = kategoriProduk;
    map['keterangan'] = keterangan;
    return map;
  }
}