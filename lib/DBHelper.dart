import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'model/Item.dart';
import 'model/Kategori.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();
  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'item.db';

    //create, read databases
    var itemDatabase = openDatabase(path, version: 7, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }

  //buat tabel baru dengan nama item
  void _createDb(Database db, int version) async {
     await db.execute('''
 CREATE TABLE kategori (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 kategoriProduk TEXT,
 keterangan TEXT
 )
 ''');
    await db.execute('''
 CREATE TABLE item (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 produk TEXT,
 harga INTEGER,
 kode TEXT,
 stok INTEGER
 )
 ''');
  }

//select databases
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('item', orderBy: 'produk');
    return mapList;
  }

  Future<List<Map<String, dynamic>>> selectkat() async {
    Database db = await this.initDb();
    var mapList = await db.query('kategori', orderBy: 'kategoriProduk');
    return mapList;
  }

//create databases
  Future<int> insert(Item object) async {
    Database db = await this.initDb();
    int count = await db.insert('item', object.toMap());
    return count;
  }

  Future<int> insertkat(Kategori object) async {
    Database db = await this.initDb();
    int count = await db.insert('kategori', object.toMap());
    return count;
  }

//update databases
  Future<int> update(Item object) async {
    Database db = await this.initDb();
    int count = await db
        .update('item', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<int> updatekat(Kategori object) async {
    Database db = await this.initDb();
    int count = await db
        .update('kategori', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('item', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<int> deletekat(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('kategori', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Item>> getItemList() async {
    var itemMapList = await select();
    int count = itemMapList.length;
    List<Item> itemList = List<Item>();
    for (int i = 0; i < count; i++) {
      itemList.add(Item.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  Future<List<Kategori>> getItemListkat() async {
    var itemMapList = await selectkat();
    int count = itemMapList.length;
    List<Kategori> itemList = List<Kategori>();
    for (int i = 0; i < count; i++) {
      itemList.add(Kategori.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
