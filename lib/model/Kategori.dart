class Item {
  int _id;
  String _kategoriProduk;

  int get id => _id;

  String get kategoriProduk => this._kategoriProduk;
  set kategoriProduk(String value) => this._kategoriProduk = value;

  // konstruktor versi 1
  Item(this._kategoriProduk);

  // konstruktor versi 2: konversi dari Map ke Item
  Item.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._kategoriProduk = map['kategoriProduk'];
  }

  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['kategoriProduk'] = kategoriProduk;
    return map;
  }
}