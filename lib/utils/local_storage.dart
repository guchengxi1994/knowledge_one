import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final _instance = LocalStorage._init();

  factory LocalStorage() => _instance;

  static SharedPreferences? _storage;

  LocalStorage._init() {
    _initStorage();
  }

  _initStorage() async {
    _storage ??= await SharedPreferences.getInstance();
  }

  Future<bool> getFirst() async {
    await _initStorage();
    return _storage!.getBool("isFirst") ?? false;
  }

  Future<void> setFirst() async {
    await _initStorage();
    await _storage!.setBool("isFirst", true);
  }
}
