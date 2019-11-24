import 'package:eicapp/models/setting.dart';
import 'package:eicapp/providers/chinese_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class LanguageProvider extends ChangeNotifier {
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
  }

  Future<void> insertSetting(Setting setting) async {
    final Database db = await database;
    await db.insert(
      'settings',
      setting.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Setting> setting(String name) async {
    final Database db = await database;
    final List<Map<String, dynamic>> languageSetting = await db
        .query('settings', where: 'name = ?', whereArgs: [name], limit: 1);
    if (languageSetting.length <= 0) {
      return null;
    }

    return Setting.fromJson(languageSetting[0]);
  }

  void selectLanguage(Language language) async {
    //Make no change if the language is already selected
    if (language == _language) return;
    Setting languageSetting = await setting('language');
    Setting settingModel = Setting(
        id: 0, name: 'language', value: Language.values.indexOf(language));

    if (languageSetting == null) {
      await insertSetting(settingModel);
    } else {
      await updateSetting(settingModel);
    }

    _language = language;
    notifyListeners();
  }

  Language get language => _language;
}

enum Language { English, Chinese }
