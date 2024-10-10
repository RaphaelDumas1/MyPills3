

import 'package:mypills3/models/crud.dart';
import 'package:mypills3/models/user.dart';
import 'package:mypills3/services/database.dart';

class UserRepository implements Crud<User> {
  @override
  Future<int> create(User user) async {
    return await (await DatabaseHelper().db).insert('user', user.toMap());
  }

  @override
  Future<User?> findById(int id) async {
    List<Map<String, dynamic>> result = await (await DatabaseHelper().db).query('user', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  @override
  Future<List<User>> findAll() async {
    return (await (await DatabaseHelper().db).query('user')).map((map) => User.fromMap(map)).toList();
  }

  @override
  Future<int> update(User user) async {
    return await (await DatabaseHelper().db).update('user', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  @override
  Future<int> delete(int id) async {
    return await(await DatabaseHelper().db).delete('user', where: 'id = ?', whereArgs: [id]);
  }

  Future<User?> findByUsername(String username) async {
    List<Map<String, dynamic>> result = await (await DatabaseHelper().db).query('user', where: 'username = ?', whereArgs: [username]);
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }
}