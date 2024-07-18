import 'package:expense_tracker/expense.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class SQLHelper {
  static Database? _database;
  static get getDatabase async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  static Future<Database> initDatabase() async {
    String path = p.join(await getDatabasesPath(), 'expenses_db.db');
    // await deleteDatabase(path);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE tableExpenses (
    id TEXT PRIMARY KEY,
    title TEXT,
    subtitle TEXT,
    amount REAL,
    source TEXT,
    date NUMERIC,
    category TEXT CHECK( category IN ('Food','Advertising','Telephone', 'Travel', 'Work'))  NOT NULL DEFAULT 'Food'
)
''');
    print('on create was called ');
  }

  static Future insertExpense(Expense expense) async {
    Database db = await getDatabase;
    await db.insert('tableExpenses', expense.toMap());
    print("insert database: ${await db.query('tableExpenses')}");

    // if (db == null) {
    //   throw Exception('Database not initialized');
    // }
  }

  static Future<List<Expense>> loadExpenses() async {
    final db = await getDatabase;
    final List<Map<String, dynamic>> maps = await db.query('tableExpenses');
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  static Future<String> delete(String id) async {
    final db = await getDatabase;
    try {
      int result =
          await db!.delete('tableExpenses', where: 'id = ?', whereArgs: [id]);
      print('Deleted id: $id, result: $result');
      return result > 0 ? 'Deleted successfully' : 'Failed to delete';
    } catch (e) {
      print("Error deleting id $id: $e");
      return 'Failed to delete: $e';
    }
  }
  // Future close() async => openDatabase('expenses_db.db').close();
}
