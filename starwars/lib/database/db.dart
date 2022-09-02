import 'package:fluttermoji/fluttermoji.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

class DB{
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database {
    if(_database != null) return _database;

    return _initDatabase();
  }

  _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'starwars.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) {
    db.execute(_avatar);
    db.insert('avatar', {
      'svg': Get.find<FluttermojiController>().getFluttermojiFromOptions()
    });
  }

  String get _avatar => '''
    CREATE TABLE avatar (
      svg TEXT PRIMARY KEY
    );
  ''';
}