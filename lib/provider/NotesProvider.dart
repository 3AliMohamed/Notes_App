import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:notes/constants/endpoint.dart';
import 'dart:convert';

import '../helpers/SharedPreferencesManager.dart';
import '../models/note_model.dart';

class NotesProvider extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes; // Method to fetch all notes from the API
  Future<String> getUserToken() async {
    String? token =  SharedPreferencesManager.getString('token');
    return token ?? "";
  }

  Future<void> fetchNotes() async {
    final response = await http.get(
      Uri.parse(APICall().apiGetNotes),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await getUserToken()}',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> list = json.decode(response.body);

      log(response.body);
      _notes = Notes.fromJson(list).data??[];
    } else {
      log(await getUserToken());
      log(response.statusCode.toString());
      throw Exception('Failed to load notes');
    }

    notifyListeners();
  }

  // Method to create a new note
  Future<void> createNote(Note note) async {
    final response = await http.post(
      Uri.parse(APICall().apiCreateNote),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await getUserToken()}',
      },
      body: jsonEncode(note.toJson()),
    );

    if (response.statusCode != 200) {log(await getUserToken());
    log(response.statusCode.toString());
      throw Exception('Failed to create note');
    }
    _notes.add(note);
    notifyListeners();
  }

  // Method to update an existing note
  Future<void> updateNote(Note note) async {
    final response = await http.post(
      Uri.parse(APICall().apiUpdateNote),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await getUserToken()}',
      },
      body: jsonEncode(note.toJson()),
    );

    if (response.statusCode != 200) {log(await getUserToken());
    log(response.statusCode.toString());
      throw Exception('Failed to update note');
    }
    // Update the note in the local list
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
    }
    notifyListeners();
  }

  // Method to delete a note
  Future<void> deleteNote(int id) async {
    final response = await http.delete(
      Uri.parse('${APICall().apiDeleteNote}$id'),
      headers: {
        'Content-Type': 'application/json',

        'Authorization': 'Bearer ${await getUserToken()}',
      },
    );

    if (response.statusCode != 200) {log(await getUserToken());
    log(response.statusCode.toString());
      throw Exception('Failed to delete note');
    }
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
