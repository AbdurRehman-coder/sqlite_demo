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
      'CREATE TABLE notes (id, INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL, pageNumber INTEGER NOT NULL, email TEXT'
    );
}
// insert data to database through toMap
 Future<DataModel> insert(DataModel dataModel) async{
var dbClient = await db;
await dbClient!.insert('notes' ,  dataModel.toMap());
return dataModel;
  }
  Future<List<DataModel>> getCartWithId() async{
    var dbClient = await db;
    final List<Map<String, Object>> queryResult = await dbClient.
  }

}
}