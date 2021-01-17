import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list_app/models/Todo.dart';

class DatabaseHelper{

  static final _databaseName    = "todolist.db";
  static final _databaseVersion = 3;
  static final table            = 'todolist';
  static final columnId         = 'id';
  static final columnTitle      = 'title';
  static final columnDatetime   = 'remindtime';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle FLOAT NOT NULL,
            $columnDatetime DATETIME
          )
          ''');
  }

  // UPGRADE DATABASE TABLES
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    print('++++++++++++++++++++++++++++++++++++++++');
    if (oldVersion <= newVersion) {
        db.execute("ALTER TABLE $table ADD COLUMN $columnDatetime TEXT;");
    }
  }

  Future<int> insert(Todo todo) async {
    Database db = await instance.database;
    var res = await db.insert(table, todo.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    var res = await db.query(table, orderBy: "$columnId ASC");
    return res;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> clearTable() async {
    Database db = await instance.database;
    return await db.rawQuery("DELETE FROM $table");
  }

}