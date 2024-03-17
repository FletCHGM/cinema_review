// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:cinema_review/feutures/film/data/model/film_review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
}

var dataBaseManager = DatabaseManager();

class DatabaseManager {
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<FirebaseFirestore> get firestore async {
    var db = FirebaseFirestore.instance;
    return db;
  }

  Future<int> get localUnixtimeUpdate async {
    var db = await database;
    var result = await db.query('LastUpdate');
    return int.parse(result.first['unixtime'].toString());
  }

  Future<int> get remoteUnixtimeUpdate async {
    var db = await firestore;
    var unixtime = 0;
    var result = await db
        .collection('films')
        .where('unixtime', isGreaterThanOrEqualTo: 0)
        .get()
        .timeout(
          const Duration(
            milliseconds: 600,
          ),
        );
    unixtime = int.parse(result.docs.first.data()['unixtime'].toString());
    return unixtime;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "favorite_films.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Films ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "description TEXT,"
          "premierDate TEXT,"
          "votesCount INTEGER,"
          "rating REAL,"
          "ageRating TEXT,"
          "cash TEXT,"
          "poster TEXT"
          ")");
      await db.execute("CREATE TABLE Actors ("
          "filmId INTEGER,"
          "name TEXT,"
          "photo TEXT,"
          "profession TEXT"
          ")");
      await db.execute("CREATE TABLE Genres ("
          "filmId INTEGER,"
          "name TEXT"
          ")");
      await db.execute("CREATE TABLE Trailers ("
          "filmId INTEGER,"
          "url TEXT,"
          "name TEXT,"
          "site TEXT,"
          "type TEXT"
          ")");
      await db.execute("CREATE TABLE LastUpdate ("
          "unixtime INTEGER"
          ")");
      await db.insert('LastUpdate', {'unixtime': 0});
    });
  }
}

insertNewFilmToLocalDatabase(FilmReviewModel film) async {
  var database = await dataBaseManager.database;
  await database.delete('LastUpdate', where: 'unixtime > 0');
  await database.insert('LastUpdate',
      {'unixtime': DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000});
  await database.insert('Films', film.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  var filmId = film.id;
  for (var actor in film.actors) {
    var element = actor.toJson();
    element.addAll({'filmId': filmId});
    await database.insert(
      'Actors',
      element,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  for (var trailer in film.trailers) {
    var element = trailer.toJson();
    element.addAll({'filmId': filmId});
    await database.insert(
      'Trailers',
      element,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  for (var genres in film.genres) {
    var element = {
      'filmId': filmId,
      'name': genres,
    };
    await database.insert('Genres', element);
  }
  try {
    var firestore = await dataBaseManager.firestore;
    var snapshot = await firestore
        .collection('films')
        .where('id', isEqualTo: film.id)
        .get();
    for (var element in snapshot.docs) {
      await element.reference.delete();
    }
    await firestore.collection('films').add({'id': film.id});
    await firestore.collection('films').doc('lastUpdate').set(
        {'unixtime': DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000});
  } on Exception catch (_) {}
  debugPrint('Insert film with id = ${film.id}');
}

insertNewFilmToRemoteDatabase(FilmReviewModel film) async {
  try {
    var firestore = await dataBaseManager.firestore;
    var snapshot = await firestore
        .collection('films')
        .where('id', isEqualTo: film.id)
        .get();
    for (var element in snapshot.docs) {
      await element.reference.delete();
    }
    await firestore.collection('films').add({'id': film.id});
    await firestore.collection('films').doc('lastUpdate').set(
        {'unixtime': DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000});
  } on Exception catch (_) {}
  debugPrint('Insert film with id = ${film.id}');
}

deleteFilmFromLocalDatabase(FilmReviewModel film) async {
  var database = await dataBaseManager.database;
  await database.delete('LastUpdate', where: 'unixtime > 0');
  await database.insert('LastUpdate',
      {'unixtime': DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000});
  await database.delete("Films", where: "id = ${film.id}");
  await database.delete("Actors", where: "filmId = ${film.id}");
  await database.delete("Genres", where: "filmId = ${film.id}");
  await database.delete("Trailers", where: "filmId = ${film.id}");
  debugPrint('Delete film with id = ${film.id}');
}

deleteFilmFromRemoteDatabase(FilmReviewModel film) async {
  try {
    var firestore = await dataBaseManager.firestore;
    var snapshot = await firestore
        .collection('films')
        .where('id', isEqualTo: film.id)
        .get();
    for (var element in snapshot.docs) {
      await element.reference.delete();
    }
    firestore.collection('films').doc('lastUpdate').set(
        {'unixtime': DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000});
  } on Exception catch (_) {}
  debugPrint('Delete film with id = ${film.id}');
}

Future<List<FilmReviewModel>> getLocalFilms() async {
  var database = await dataBaseManager.database;
  List<FilmReviewModel> result = [];
  var filmListMap = await database.query('Films');
  for (var filmMap in filmListMap) {
    var genres =
        await database.query('Genres', where: 'filmId = ${filmMap['id']}');

    var actors =
        await database.query('Actors', where: 'filmId = ${filmMap['id']}');
    var trailers =
        await database.query('Trailers', where: 'filmId = ${filmMap['id']}');
    Map<String, dynamic> element = {
      'genres': List.generate(
        genres.length,
        (index) => genres[index],
      ),
      'actors': List.generate(
        actors.length,
        (index) => actors[index],
      ),
      'trailers': List.generate(
        trailers.length,
        (index) => trailers[index],
      ),
    };
    element.addAll(filmMap);
    result.add(FilmReviewModel.fromMap(element));
  }

  debugPrint('Get films');
  return result;
}

Future<List<int>> getRemoteFilms() async {
  var firestore = await dataBaseManager.firestore;
  List<int> result = [];
  var snapshot = await firestore
      .collection('films')
      .where('id', isGreaterThanOrEqualTo: 450)
      .get();
  for (var doc in snapshot.docs) {
    result.add(doc.data()['id']);
  }

  debugPrint('Get films');
  return result;
}

Future<void> clearLocalDatabase() async {
  var database = await dataBaseManager.database;
  await database.delete('films');
  await database.delete('Actors');
  await database.delete('Genres');
  await database.delete('Trailers');
}

Future<void> clearRemoteDatabase() async {
  var firestore = await dataBaseManager.firestore;
  var snapshot = await firestore
      .collection('films')
      .where('id', isGreaterThanOrEqualTo: 450)
      .get();
  for (var doc in snapshot.docs) {
    await doc.reference.delete();
  }
}
