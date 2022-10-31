import 'package:notion_assistant/data_model/database_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String tokenKey = "t";
  static const String databaseListKey = "dl";
  static const String notionDomainKey = "nd";

  late SharedPreferences _preferences;

  LocalStorage() {
    _loadPreference();
  }

  Future setNotionDomain(String domain) async {
    await _preferences.setString(notionDomainKey, domain);
  }

  String? getNotionDomain() {
    return _preferences.getString(notionDomainKey);
  }

  Future setToken(String token) async {
    await _preferences.setString(tokenKey, token);
  }

  String? getToken() {
    return _preferences.getString(tokenKey);
  }

  bool hasToken() {
    return getToken() != null;
  }

  String? getDatabaseId(DatabaseType type) {
    return _preferences.getString(type.value + databaseListKey);
  }

  Future setDatabaseId(DatabaseType type, String id) async {
    await _preferences.setString(type.value + databaseListKey, id);
  }

  bool hasDatabase(DatabaseType type) {
    return getDatabaseId(type) != null;
  }

  void _loadPreference() async {
    _preferences = await SharedPreferences.getInstance();
  }
}
