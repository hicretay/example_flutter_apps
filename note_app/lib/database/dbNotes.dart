import 'dart:async';

import 'package:note_app/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbNotes {
  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "notes.db");
    var notesDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return notesDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table notes(id integer primary key, title text, description text)");
  }

  Future<List<Note>> getNotes() async {
    Database db = await this.db;
    var result = await db.query("notes");
    return List.generate(result.length, (i) {
      return Note.fromObject(result[i]);
    });
  }

  Future<int> insert(Note note) async {
    Database db = await this.db;
    var result = await db.insert("notes", note.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.delete("notes", where: "id=?", whereArgs: [id]);
    return result;
  }

  Future<int> update(int id, Note note) async {
    Database db = await this.db;
    var result =
        await db.update("notes", note.toMap(), where: "id=?", whereArgs: [id]);
    return result;
  }
}
