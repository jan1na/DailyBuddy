import 'dart:io';
import 'dart:async';

import 'package:DailyBuddy/models/dayplan.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final dayplanTABLE = 'dayplan';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"DailyBuddy.db is our database instance name
    String path = join(documentsDirectory.path, "DailyBuddy.db");

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $dayplanTABLE ("
        "id INTEGER PRIMARY KEY, "
        "date DATETIME, "
        "activity TEXT, "
        "is_done INTEGER, "
        "picture TEXT "
        ")");
  }
  /*
	 * Dayplan Table
	 */

  getDayplans() async {
    final db = await database;
    var res = await db.query(dayplanTABLE);
    List<Dayplan> dayplans = res.isNotEmpty
        ? res.map((note) => Dayplan.fromJson(note)).toList()
        : [];

    return dayplans;
  }

  newDayplan(Dayplan dayplan) async {
    final db = await database;
    var res = await db.insert(dayplanTABLE, dayplan.toJson());

    return res;
  }

  getDayplan(int id) async {
    final db = await database;
    var res = await db.query(dayplanTABLE, where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? Dayplan.fromJson(res.first) : null;
  }

  updateDayplan(Dayplan dayplan) async {
    final db = await database;
    var res = await db.update(dayplanTABLE, dayplan.toJson(),
        where: 'id = ?', whereArgs: [dayplan.id]);

    return res;
  }

  deleteDayplan(int id) async {
    final db = await database;
    db.delete(dayplanTABLE, where: 'id = ?', whereArgs: [id]);
  }
}
