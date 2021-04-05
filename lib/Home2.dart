import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'DBHelper.dart';
import 'EntryForm2.dart';
import 'model/Kategori.dart';

//pendukung program asinkron
class Home2 extends StatefulWidget {
  @override
  Home2State createState() => Home2State();
}

class Home2State extends State<Home2> {
  DbHelper dbHelper = DbHelper(); //panggil class db helper
  int count = 0;
  List<Kategori> kategoriList; // deklarasi list
  @override
  Widget build(BuildContext context) {
    if (kategoriList == null) {
      kategoriList = List<Kategori>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Over'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Tambah Produk"),
              onPressed: () async {
                var kategori= await navigateToEntryForm(context, null);
                if (kategori != null) {
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insertkat(kategori);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<Kategori> navigateToEntryForm(BuildContext context, Kategori kategori) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm2(kategori);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.kategoriList[index].kategoriProduk,
              style: textStyle,
            ),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
              int result = await dbHelper.delete(this.kategoriList[index].id);
                  if (result > 0) {
                    updateListView();
                  }
              },
            ),
            onTap: () async {
              var kategori =
                  await navigateToEntryForm(context, this.kategoriList[index]);
              //TODO 4 Panggil Fungsi untuk Edit data
                  int result = await dbHelper.updatekat(kategori);
                  if (result > 0) {
                    updateListView();
                  }
            },
          ),
        );
      },
    );
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Kategori>> itemListFuture = dbHelper.getItemListkat();
      itemListFuture.then((kategoriList) {
        setState(() {
          this.kategoriList = kategoriList;
          this.count = kategoriList.length;
        });
      });
    });
  }
}
