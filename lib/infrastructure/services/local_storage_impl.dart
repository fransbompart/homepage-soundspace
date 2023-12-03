import 'package:shared_preferences/shared_preferences.dart';
import '../../application/services/local_storage.dart';

class LocalStorageImpl extends LocalStorage {
  final SharedPreferences _prefs;

  LocalStorageImpl({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  String? getValue(String key) {
    return _prefs.getString(key);
  }

  @override
  Future<bool> removeKey(String key) async {
    return await _prefs.remove(key);
  }

  @override
  void setKeyValue(String key, String value) {
    _prefs.setString(key, value);
  }
}
