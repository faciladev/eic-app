import 'package:eicapp/models/setting.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SettingProvider extends ChangeNotifier {
  List<Setting> allSettings;
  Language _language;
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'eic_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE settings(id INTEGER PRIMARY KEY, name TEXT, value INTEGER)');
      },
      version: 1,
    );
  }

  Future<void> updateSetting(Setting setting) async {
    final Database db = await database;

    await db.update('settings', setting.toMap(),
        where: 'name = ?', whereArgs: [setting.name]);
    await loadSettings();
  }

  Future<void> insertSetting(Setting setting) async {
    final Database db = await database;
    await db.insert(
      'settings',
      setting.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await loadSettings();
  }

  // Future<Setting> loadSetting(String name) async {
  //   final Database db = await database;
  //   final List<Map<String, dynamic>> languageSetting = await db
  //       .query('settings', where: 'name = ?', whereArgs: [name], limit: 1);
  //   if (languageSetting.length <= 0) {
  //     return null;
  //   }

  //   return Setting.fromJson(languageSetting[0]);
  // }

  Future<void> loadSettings() async {
    final Database db = await database;
    final List<Map<String, dynamic>> settings = await db.query('settings');
    if (settings.length <= 0) {
      return;
    }

    allSettings = List.generate(settings.length, (index) {
      return Setting.fromJson(settings[index]);
    });

    loadLanguage();
    notifyListeners();
  }

  void loadLanguage() {
    allSettings.forEach((setting) {
      if (setting.name == 'language') {
        _language = Language.values.elementAt(setting.value);
      }
    });
  }

  Setting getSetting(String name) {
    if (allSettings == null) return null;
    return allSettings.firstWhere((setting) => setting.name == name);
  }

  Language get language => _language;

  void selectLanguage(Language language) async {
    if (language == _language) return;
    Setting settingModel = Setting(
        id: 0, name: 'language', value: Language.values.indexOf(language));

    if (_language == null) {
      await insertSetting(settingModel);
    } else {
      await updateSetting(settingModel);
    }
  }
}

enum Language { English, Chinese }
