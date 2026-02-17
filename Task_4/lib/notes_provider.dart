import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'note.dart';

class NotesProvider extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  String _searchQuery = "";

  List<Note> get notes =>
      _searchQuery.isEmpty ? _notes : _filteredNotes;

  NotesProvider() {
    loadNotes();
  }

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('notes');

    if (data != null) {
      final List decoded = jsonDecode(data);
      _notes = decoded.map((e) => Note.fromJson(e)).toList();
      notifyListeners();
    }
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
    jsonEncode(_notes.map((e) => e.toJson()).toList());
    await prefs.setString('notes', encoded);
  }

  Future<void> addNote(Note note) async {
    _notes.add(note);
    await saveNotes();
    notifyListeners();
  }

  Future<void> updateNote(String id, String title,
      String description) async {
    final index =
    _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      _notes[index].title = title;
      _notes[index].description = description;
      await saveNotes();
      notifyListeners();
    }
  }

  Future<void> deleteNote(String id) async {
    _notes.removeWhere((note) => note.id == id);
    await saveNotes();
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query;

    _filteredNotes = _notes
        .where((note) =>
    note.title
        .toLowerCase()
        .contains(query.toLowerCase()) ||
        note.description
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    notifyListeners();
  }
}
