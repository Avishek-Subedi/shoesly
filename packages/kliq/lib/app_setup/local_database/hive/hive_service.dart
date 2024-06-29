import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

class HiveService<T> {
  final String _boxName;
  late Box<T> _box;

  HiveService(this._boxName) {
    _box = Hive.box<T>(_boxName);
  }

  /// Get a single item from the box by its [key].
  Future<T?> getItem(String key) async {
    try {
      log('data', name: 'is item exists from local');
      return _box.get(key);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> putItems({required String itemKey, required T item}) async {
    try {
      return _box.put(itemKey, item);
    } catch (e) {
      rethrow;
    }
  }

  /// Get all favorite news items
  Future<List<T>> get() async {
    try {
      return _box.values.toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Delete a news item from favorites by key
  Future<void> delete(String key) async {
    try {
      await _box.delete(key);
    } catch (e) {
      rethrow;
    }
  }

  /// Close the box
  Future<void> closeBox() async {
    try {
      await _box.close();
    } catch (e) {
      rethrow;
    }
  }
}
