import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'grades_model.dart';
import '../utils/constants.dart';
import '../services/api_service.dart';
import 'student_model.dart';

class UserSecureStorage {
  static final _storage = new FlutterSecureStorage();

  static Future setUserToken(String token) async =>
      await _storage.write(key: "access_token", value: token);

  static Future<String>? getUserToken() async =>
      await _storage.read(key: "access_token") as String;

  static Future setUserName(String username) async =>
      await _storage.write(key: "username", value: username);

  static Future<String>? getUserName() async =>
      await _storage.read(key: "username") as String;

  static Future setFirstName(String firstname) async =>
      await _storage.write(key: "firstname", value: firstname);

  static Future<String>? getFirstName() async =>
      await _storage.read(key: "firstname") as String;

  static Future setClassStart(String classStart) async =>
      await _storage.write(key: "classStart", value: classStart);

  static Future<String>? getClassStart() async =>
      await _storage.read(key: "classStart") as String;

  static Future setAysem(String aysem) async =>
      await _storage.write(key: "aysem", value: aysem);

  static Future<String>? getAysem() async =>
      await _storage.read(key: "aysem") as String;

  static Future setItem(String itemName) async =>
      await _storage.write(key: "itemName", value: itemName);

  static Future<String>? getItem() async =>
      await _storage.read(key: "itemName") as String;

  static Future<String> setAmtDue(String amtDue) async =>
      await _storage.write(key: "amtDue", value: amtDue) as String;

  static Future<String>? getAmtDue() async =>
      await _storage.read(key: "amtDue") as String;

  static Future setLastName(String lastname) async =>
      await _storage.write(key: "lastname", value: lastname);

  static Future<String>? getLastName() async =>
      await _storage.read(key: "lastname") as String;

  static Future setUserId(String userid) async =>
      await _storage.write(key: "userid", value: userid);

  static Future<String>? getUserId() async =>
      await _storage.read(key: "userid") as String;

  static Future<String> setUserRole(String role) async =>
      await _storage.write(key: "role", value: role) as String;

  static Future<String>? getUserRole() async =>
      await _storage.read(key: "role") as String;

  static Future setUserEmail(String email) async =>
      await _storage.write(key: "plmemail", value: email);

  static Future<String>? getUserEmail() async =>
      await _storage.read(key: "plmemail") as String;

  static Future<bool> isLogged() async {
    try {
      final user = await _storage.read(key: 'access_token');
      return user != null;
    } catch (e) {
      return false;
    }
  }
}

getStudentInformation() async {
  APIService apiService = new APIService();
  apiService.user().then((value) async => {
        await UserSecureStorage.setFirstName(value.firstname),
        await UserSecureStorage.setUserName(value.lastname),
        await UserSecureStorage.setUserEmail(value.email),
      });
}

getSchoolInformation() async {
  APIService apiService = new APIService();
  apiService.schoolInfo().then((value) async => {
    await UserSecureStorage.setClassStart(value.classStart),
  });
}

logOut() async {
  final storage = new FlutterSecureStorage();
  await storage.deleteAll();
}
