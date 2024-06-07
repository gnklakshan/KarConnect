import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  static final TLocalStorage _instance = TLocalStorage._internal();
  factory TLocalStorage() {
    return _instance;
  }

  TLocalStorage._internal();
  final storage = GetStorage();

  // Generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await storage.write(key, value);
  }

  // Generic method to read data
  T? readData<T>(String key) {
    return storage.read<T>(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await storage.remove(key);
  }

  // Clear all data in storage
  Future<void> clearAll() async {
    await storage.erase();
  }
}
