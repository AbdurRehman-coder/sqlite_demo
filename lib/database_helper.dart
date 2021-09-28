import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqlite_demo/dataModel.dart';

class DBHelper{
  //create Database instance
  static Database? _db;
  Future<Database?> get db async{
    if( _db != null ){
      return  _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

// it will run Query into database
_onCreate(Database db, int version) async{
    await db.execute(
        "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,age INTEGER NOT NULL, description TEXT NOT NULL, email TEXT)"
    );
}
// insert data to database through toMap
 Future<DataModel> insert(DataModel dataModel) async{
var dbClient = await db;
await dbClient!.insert('notes' ,  dataModel.toMap());
return dataModel;
  }
  //it will get all the data from database and decode the json data
  // with help of DataModel.fromMap() name_constructor
  Future<List<DataModel>> getCartWithId() async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('notes');
    return queryResult.map((e) => DataModel.fromMap(e)).toList();
  }

  //Delete table content
Future deleteTableContent() async{
    var dbClient = await db;
    return await dbClient!.delete(
      'notes'
    );
}
// Delete some specific product
Future<int> deleteProducts(int id) async{
    var dbClient = await db;
    return await dbClient!.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id]
    );
}
//updating database
Future<int> updateQuantity(DataModel dataModel) async{
    var dbClient = await db;
    return await dbClient!.update(
    'notes',
      dataModel.toMap(),
      where: 'id = ?',
      whereArgs: [dataModel.id],

        );
}

//Close database
Future close() async {
    var dbClient = await db;
    return await dbClient!.close();
}

}