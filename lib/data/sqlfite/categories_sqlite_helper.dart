// import 'package:expense_tracker/utils/expense.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart' as p;

// class CategoriesSqliteHelper {
//   static Database? _database;
//   static get getDatabase async {
//     if (_database != null) return _database;
//     _database = await initDatabase();
//     return _database;
//   }

//   static Future<Database> initDatabase() async {
//     String path = p.join(await getDatabasesPath(), 'Total_expenses_db.db');
//     // await deleteDatabase(path);

//     return await openDatabase(path, version: 1, onCreate: _onCreate);
//   }

//   static Future _onCreate(Database db, int version) async {
//     await db.execute('''
// CREATE TABLE tableCategories (
//     id TEXT PRIMARY KEY,
//     title TEXT,
//     amount REAL,
//     icon TEXT CHECK( category IN ('Food','Advertising','Telephone', 'Travel', 'Work'))  NOT NULL DEFAULT 'Food',
//     FOREIGN KEY (group_id)
//        REFERENCES supplier_groups (group_id) 
// )
// ''');
//     print('on create categories was called');
//   }
// }
