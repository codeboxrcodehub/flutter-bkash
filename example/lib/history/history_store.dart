import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'history_entry.dart';

/// On-device persistence for [HistoryEntry] records, backed by
/// SharedPreferences (a JSON-encoded string list; fine for a demo's volume).
class HistoryStore {
  static const _key = 'bkash_demo_history';

  Future<List<HistoryEntry>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    return raw
        .map((s) => HistoryEntry.fromJson(json.decode(s) as Map<String, dynamic>))
        .toList();
  }

  /// Newest entries are kept first so the history list needs no sorting.
  Future<void> add(HistoryEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    raw.insert(0, json.encode(entry.toJson()));
    await prefs.setStringList(_key, raw);
  }

  Future<void> remove(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    raw.removeWhere(
        (s) => (json.decode(s) as Map<String, dynamic>)['id'] == id);
    await prefs.setStringList(_key, raw);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
