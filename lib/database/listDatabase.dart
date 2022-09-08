// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_todo_app/model/listData_model.dart';

class ListDatabase {
  static final ListDatabase instance = ListDatabase._init();

  static Database? _database;

  ListDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT';

    await db.execute('''
CREATE TABLE $tableLists ( 
  ${ListField.id} $idType,
  ${ListField.name} $textType, 
  ${ListField.email} $textType, 
  ${ListField.mobileNumber} $textType,
  ${ListField.description} $textType,
  ${ListField.createdTime} $textType
  )
''');
  }

  Future<ListData> create(ListData note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // // ignore: prefer_const_declarations
    // final columns =
    //     '${ListField.name}, ${ListField.email}, ${ListField.mobileNumber}, ${ListField.description}, ${ListField.createdTime}';
    // final values =
    //     '${json[ListField.name]}, ${json[ListField.email]}, ${json[ListField.mobileNumber]}, ${json[ListField.description]}, ${json[ListField.createdTime]}';
    // final id = await db
    //     .rawInsert('INSERT INTO $tableLists ($columns) VALUES ($values)');
    final id = await db.insert(
      tableLists,
      note.toJson(),
    );
    return note.copy(id: id);
  }

  Future<ListData> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableLists,
      columns: ListField.values,
      where: '${ListField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ListData.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ListData>> readAllNotes() async {
    final db = await instance.database;

    const orderBy = '${ListField.createdTime} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableLists, orderBy: orderBy);

    return result.map((json) => ListData.fromJson(json)).toList();
  }

  Future<int> update(ListData note) async {
    final db = await instance.database;

    return db.update(
      tableLists,
      note.toJson(),
      where: '${ListField.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableLists,
      where: '${ListField.id} = ?',
      whereArgs: [id],
    );
  }

  // Future close() async {
  //   final db = await instance.database;

  //   db.close();
  // }
}
