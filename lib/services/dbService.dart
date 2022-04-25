import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../modele/tache.dart';


class DB {

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE taches(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nom TEXT,
        description TEXT,
        priorite TEXT,
        statut TEXT,
        debut TEXT,
        fin TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'todolist.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<Tache> createTache(Tache tache) async {
    final db = await DB.db();
    tache.setId(await db.insert('taches', tache.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace));
    return tache;
  }

  static Future<List<Tache>> getTaches(int type) async {
    List<Map<String, dynamic>> jsons =[];
    List<Tache> taches =[];
    final db = await DB.db();
    if(type==1){
      jsons = await db.query('taches', orderBy: "id");
    }
    if(type==2){
      jsons = await db.query('taches', orderBy: "id", where: "statut = ?", whereArgs: ["Terminé"],);
    }
    if(type==3){
      jsons = await db.query('taches', orderBy: "id", where: "statut = ?", whereArgs: ["En cour"]);
    }
    if(type==4){
      jsons = await db.query('taches', orderBy: "id", where: "statut = ? AND priorite = ?", whereArgs: ["En cour","Prioritaire"]);
    }
    if(type==5){
      jsons = await db.query('taches', orderBy: "id",  where: "statut = ? AND priorite = ?", whereArgs: ["En cour","Non Prioritaire"]);
    }

    if(jsons.length>0){
      for(int i = 0; i<jsons.length; i++){
        taches.add(Tache.fromJson(jsons[i]));
      }
    }

    return taches;
  }

  static Future<Tache> getTache(Tache tache) async {
    List<Map<String,dynamic>> jsons =[];
    Map<String,dynamic> json ={};
    final db = await DB.db();
    jsons = await db.query('taches', where: "id = ?", whereArgs: [tache.getId()], limit: 1);
    if(jsons.length>0){
      json = jsons[0];
      tache = Tache.fromJson(json);
    }
    return tache;
  }


  static Future<Tache> updateTache(Tache tache) async {
    final db = await DB.db();
    await db.update('taches', tache.toJson(), where: "id = ?", whereArgs: [tache.getId()]);
    return tache;
  }
  static Future<void> deleteTache(Tache tache) async {
    final db = await DB.db();
    try {
      await db.delete("taches", where: "id = ?", whereArgs: [tache.getId()]);
    } catch (err) {
      debugPrint("Quelque chose s'est mal passé lors de la suppression : $err");
    }
  }
}