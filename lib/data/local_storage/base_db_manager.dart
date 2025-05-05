import 'package:hive_flutter/adapters.dart';

abstract class BaseDbManager<T extends HiveObject> {
  final String key;
  Box<T?>? _box;

  BaseDbManager(this.key);

  Future<void> init() async {
    registerAdapters();
    _box = await Hive.openBox(key);
  }

  void registerAdapters();

  Future<void> clearAll() async {
    try {
      await _box?.clear();
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> addItem(T model) async {
    try {
      return await _box?.add(model);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addItems(List<T> items) async {
    try {
      await _box?.addAll(items);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> putItems(List<T> items) async {
    try {
      putItems(items);
    } catch (e) {
      rethrow;
    }
  }

  T? getItem(dynamic key) {
    try {
      return _box?.get(key);
    } catch (e) {
      rethrow;
    }
  }

  ///quasry parametresi kotrol edilecvek
  List<T?>? getValues(bool Function(T? element) test) {
    try {
      var values = _box?.values.where(test).toList();
      return values;
    } catch (e) {
      rethrow;
    }
  }

  List<T?>? getAllValues() {
    try {
      return _box?.values.toList();
    } catch (e) {
      rethrow;
    }
  }

  T? getFist() {
    try {
      return _box?.values.firstWhere((element) => true, orElse: () => null);
    } catch (e) {
      rethrow;
    }
  }

  T? getFistWhere(bool Function(T? element) q) {
    try {
      return _box?.values.firstWhere(q, orElse: () => null);
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> putItem(int key, T item) async {
    try {
      await _box?.put(key, item);
      return 1;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeItem(int key) async {
    try {
      await _box?.delete(key);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeItems(List<T?> keys) async {
    try {
      await _box?.deleteAll(keys);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeItemByObject(T item) async {
    try {
      // Objeyi bul ve anahtarını al
      final key = _box?.keys.firstWhere(
        (k) => _box?.get(k) == item,
        orElse: () => null,
      );

      // Eğer anahtar bulunursa sil
      if (key != null) {
        await _box?.delete(key);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeItemByQuery(bool Function(T? element) query) async {
    try {
      // Sorguya uyan objelerin anahtarlarını bul
      final keysToDelete = _box?.keys.where((key) {
        final item = _box?.get(key);
        return query(item);
      }).toList();

      // Eğer anahtarlar varsa sil
      if (keysToDelete != null && keysToDelete.isNotEmpty) {
        await _box?.deleteAll(keysToDelete);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> closeBox() async {
    try {
      await _box?.close();
    } catch (e) {
      rethrow;
    }
  }
}
