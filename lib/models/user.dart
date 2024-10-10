import 'package:mypills3/services/database.dart';

class User {
  final String username;
  final String email;
  final String password;
  final int? id;
  final String? salt;

  User({
    this.id,
    required this.username, 
    required this.email,
    required this.password,
    this.salt
  });

  Map<String, dynamic> toMap() {
    var salt = DatabaseHelper().generateSalt();
    return {
      'username': username.toString(),
      'email': email.toString(),
      'password': DatabaseHelper().hashPassword(password, salt).toString(),
      'salt' : salt
    };
  }

  factory User.fromMap(Map<String, dynamic> json) => User(
    id : json["id"],
    username: json["username"],
    email : json["email"],
    password : json["password"],
    salt: json["salt"]
  );
}