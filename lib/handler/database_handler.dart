import 'dart:async';
import 'package:googlemap_demo/model/login_user_model.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class DbManager {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'product.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE productTable(id INTEGER, name TEXT,  username TEXT ,email TEXT ,phone TEXT, website TEXT ,street TEXT, suite TEXT ,city TEXT ,lat TEXT , lng TEXT, companyName TEXT,  catchPhrase TEXT , bs TEXT ,zipcode TEXT )",
        );
      },
    );
  }

  Future insertModel(Map<String, dynamic> map) async {
    final Database db = await initializedDB();
    var result = 0;
    //LoginUserDialogModel userDialogModel = LoginUserDialogModel.fromJson(map);

    result = await db.insert('productTable', map);
    // for (var planet in model) {
    //   result = await db.insert('productTable', planet.toJson());
    //   print(result);
    // }
    return result;
  }

  Future<bool> tableIsEmpty() async {
    var db = await openDatabase('product.db');
    List map = await db.rawQuery('SELECT * FROM productTable');
    if (map.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<LoginUserDialogModel>> getModelList() async {
    List<LoginUserDialogModel> attraction = [];
    List<LoginUserDialogModel> viewLoginUserDialogModel = [];
    final Database db = await initializedDB();
    final List<Map<String, dynamic>> maps = await db.query('productTable');
    List.generate(maps.length, (i) {
      attraction.add(LoginUserDialogModel(
          id: maps[i]['id'],
          name: maps[i]['name'],
          username: maps[i]['username'],
          email: maps[i]['email'],
          address: Address(
              street: maps[i]['street'],
              suite: maps[i]['suite'],
              city: maps[i]['city'],
              zipcode: maps[i]['zipcode'],
              geo: Geo(lat: maps[i]['lat'], lng: maps[i]['lng'])),
          phone: maps[i]['phone'],
          website: maps[i]['website'],
          company: Company(
              name: maps[i]['companyName'],
              catchPhrase: maps[i]['catchPhrase'],
              bs: maps[i]['bs'])));
    });

    return attraction;
  }

  Future<int> updateModel(LoginUserDialogModel model, bool isIncrement) async {
    final Database db = await initializedDB();

    final updateLoginUserDialogModel = LoginUserDialogModel(
        id: model.id,
        name: model.name,
        username: model.username,
        email: model.email,
        address: model.address,
        phone: model.phone,
        website: model.website,
        company: model.company);

    int result = await db.update(
        'productTable', updateLoginUserDialogModel.toJson(),
        where: "id =?", whereArgs: [model.id]);
    print(result);
    return result;
  }

  // Future<void> deleteModel(LoginUserDialogModel model) async {
  //   await openDb();
  //   await database.delete('model', where: "id = ?", whereArgs: [model.id]);
  // }

  // getCartData() async {
  //   List<LoginUserDialogModel> attraction = [];

  //   final Database db = await initializedDB();
  //   attraction = await db.rawQuery('SELECT * FROM productTable');
  //   result.where((ele))
  //   print("====>");
  //   print(result);
  // }
}
