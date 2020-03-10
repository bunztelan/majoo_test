import 'dart:async';
import 'package:majoo_test/data/database/database.dart';
import 'package:majoo_test/model/people.dart';

class PeopleDao {
  final dbProvider = DBProvider.db;

  String peopleTABLE="people";

  //Adds new Todo records
  Future<int> createPeople(People people) async {
    final db = await dbProvider.database;
    var result = db.insert(peopleTABLE, people.toDbJson());
    return result;
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<People>> getPeople({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(peopleTABLE,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(peopleTABLE, columns: columns);
    }

    List<People> peoples = result.isNotEmpty
        ? result.map((item) => People.fromJson(item)).toList()
        : [];
    return peoples;
  }

  //Update Todo record
  Future<int> updatePeople(People todo) async {
    final db = await dbProvider.database;

    var result = await db.update("People", todo.toJson(),
        where: "id = ?", whereArgs: [todo.id]);

    return result;
  }

  //Delete Todo records
  Future<int> deletePeople(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(peopleTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllPeople() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      peopleTABLE,
    );

    return result;
  }
}