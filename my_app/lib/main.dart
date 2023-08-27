import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'flutter_database.db'),
    version: 1,
    onCreate: (db, version) {
      print("connect success");
      return db.execute("CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)");
    }
  );
  Future<void> insertDog(Dog dog) async {
    final Database db = await database;
    await db.insert('dogs', dog.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Dog>> dogs() async{
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age']
      );
    });
  }

  Future<void> updateDog(Dog dog) async {
    final db = await database;
    await db.update('dogs', dog.toMap(), where: "id = ?", whereArgs: [dog.id]);
  }

  Future<void> deleteDog(int id) async {
    final db = await database;
    await db.delete('dogs', where: "id = ?", whereArgs: [id]);
  }

  var kowit = Dog(
    id: 0,
    name: 'Kowit',
    age: 35
  );

  await insertDog(kowit);
  print(await dogs());

  kowit = Dog(
    id: kowit.id,
    name: kowit.name,
    age: kowit.age + 7
  );

  await updateDog(kowit);
  print(await dogs());

  await deleteDog(kowit.id);
  print(await dogs());
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
