import 'package:flutter/foundation.dart';
import '../models/time_entry.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
class TimeEntryProvider with ChangeNotifier {
  final LocalStorage storage;
  List<TimeEntry> _entries = [];
  List<TimeEntry> get entries => _entries;
  TimeEntryProvider(this.storage) {
    _loadEntriesFromStorage();
  }
  void _loadEntriesFromStorage() async {
    var storedEntries = storage.getItem('time_entries');
    if (storedEntries != null) {
      _entries = List<TimeEntry>.from(
        (storedEntries as List).map((item) => TimeEntry.fromJson(item)),
      );
      notifyListeners();
    }
  }
  // Add a time entry
  void addTimeEntry(TimeEntry entry) {
    _entries.add(entry);
    _saveEntriesToStorage();
    notifyListeners();
  }
  void _saveEntriesToStorage() {
    storage.setItem(
        'time_entries', jsonEncode(_entries.map((e) => e.toJson()).toList()));
  }
  // Delete a time entry
  void deleteTimeEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    _saveEntriesToStorage(); // Save the updated list to local storage
    notifyListeners();
  }
  // Add or update a time entry
  void addOrUpdateTimeEntry(TimeEntry entry) {
    int index = _entries.indexWhere((e) => e.id == entry.id);
    if (index != -1) {
      // Update existing entry
      _entries[index] = entry;
    } else {
      // Add new entry
      _entries.add(entry);
    }
    _saveEntriesToStorage(); // Save the updated list to local storage
    notifyListeners();
  }
}
