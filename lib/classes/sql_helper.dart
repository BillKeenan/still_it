import 'package:distillers_calculator/model/batch.dart';
import 'package:distillers_calculator/model/image_note.dart';
import 'package:distillers_calculator/model/specific_gravity_note.dart';
import 'package:distillers_calculator/model/text_note.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE batch(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        description TEXT,
        archived INTEGER,
        batchStartedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    await database.execute("""CREATE TABLE textNote(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        note TEXT,
        batch INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    await database.execute("""CREATE TABLE specificGravityNote(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        sg REAL,
        batch INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    await database.execute("""CREATE TABLE imageNote(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        imagePath TEXT,
        batch INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    await database.execute("""CREATE INDEX imageNote_batch 
        ON imageNote(batch);""");

    await database.execute("""CREATE INDEX textNote_batch 
        ON textNote(batch);""");

    await database.execute("""CREATE INDEX specificGravityNote_batch 
        ON specificGravityNote(batch);""");
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'kindacode.db',
      version: 3,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
      onUpgrade: (sql.Database database, int oldVersion, int newVersion) async {
        await upgradeDB(database, oldVersion, newVersion);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createBatch(
      String name, String? description, DateTime selectedDate) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'description': description,
      'batchStartedDate': selectedDate.toString(),
      'archived': 0
    };
    final id = await db.insert('batch', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<Batch> getBatch(int id) async {
    final db = await SQLHelper.db();

    List<Map<String, dynamic>> maps = await db.query('items',
        columns: ['id', 'name', 'description', 'batchStartedDate'],
        where: 'id = ?',
        whereArgs: [id]);

    return Batch.fromMap(maps.first);
  }

  // Update an item by id
  static Future<int> updateBatch(Batch batch) async {
    final db = await SQLHelper.db();

    final data = {
      'name': batch.name,
      'description': batch.description,
      'batchStartedDate': batch.batchStartedDate.toString()
    };

    final result =
        await db.update('batch', data, where: "id = ?", whereArgs: [batch.id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("batch", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<int> saveNote(int batchId, String note) async {
    final db = await SQLHelper.db();

    final data = {'note': note, 'batch': batchId};
    final id = await db.insert('textNote', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<TextNote>> getTextNotes(int id) async {
    final db = await SQLHelper.db();

    List<Map<String, dynamic>> maps = await db.query('textNote',
        columns: ['id', 'note', 'batch', 'createdAt'],
        where: 'batch = ?',
        whereArgs: [id],
        orderBy: "createdAt desc");

    List<TextNote> notes = [];
    for (var element in maps) {
      notes.add(TextNote.fromMap(element));
    }

    return notes;
  }

  static Future<int> saveImageNote(int batchId, String imagePath) async {
    final db = await SQLHelper.db();

    final data = {'imagePath': imagePath, 'batch': batchId};
    final id = await db.insert('imageNote', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<ImageNote>> getImageNotes(int batchID) async {
    final db = await SQLHelper.db();

    List<Map<String, dynamic>> maps = await db.query('imageNote',
        columns: ['id', 'imagePath', 'batch', 'createdAt'],
        where: 'batch = ?',
        whereArgs: [batchID],
        orderBy: "createdAt desc");

    List<ImageNote> imageNotes = [];
    for (var element in maps) {
      imageNotes.add(ImageNote.fromMap(element));
    }

    return imageNotes;
  }

  static void saveImage(int i, String path) {}

  // Read all items (journals)
  static Future<List<Batch>> getBatches() async {
    final db = await SQLHelper.db();
    var maps = await db.query('batch', orderBy: "id", where: "archived = 0");

    List<Batch> batches = [];

    for (var row in maps) {
      batches.add(Batch.fromMap(row));
    }

    return batches;
  }

  static Future<int> saveSG(int batchId, num sg) async {
    final db = await SQLHelper.db();

    final data = {'sg': sg, 'batch': batchId};
    final id = await db.insert('specificGravityNote', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static getSpecificGravityNotes(int batchID) async {
    final db = await SQLHelper.db();

    List<Map<String, dynamic>> maps = await db.query('specificGravityNote',
        columns: ['id', 'sg', 'batch', 'createdAt'],
        where: 'batch = ?',
        whereArgs: [batchID],
        orderBy: "createdAt desc");

    List<SpecificGravityNote> imageNotes = [];
    for (var element in maps) {
      imageNotes.add(SpecificGravityNote.fromMap(element));
    }

    return imageNotes;
  }

  static upgradeDB(
      sql.Database database, int oldVersion, int newVersion) async {
    if (oldVersion == 1) {
      await database.execute("""ALTER TABLE batch 
        ADD batchStartedDate TIMESTAMP
      """);

      await database.execute("""UPDATE batch 
        set batchStartedDate  =  CURRENT_TIMESTAMP
      """);
    } else if (oldVersion == 2) {
      await database.execute("""ALTER TABLE batch 
        ADD archived INTEGER
      """);
      await database.execute("""UPDATE batch 
        set archived  =  0
      """);
    }
  }

  static archiveBatch(int id) async {
    final db = await SQLHelper.db();

    final data = {'archived': 1};

    final result =
        await db.update('batch', data, where: "id = ?", whereArgs: [id]);
    return result;
  }
}
