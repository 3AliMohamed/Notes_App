import 'dart:convert';
import 'package:http/http.dart' as http;

class NotesController {
  final String apiUrl = 'https://back-notes.generalhouseservices.com/public/api';

  // Method to fetch all notes from the API
  Future<List<Note>> getNotes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      List<Note> notesList = List<Note>.from(list.map((model) => Note.fromJson(model)));
      return notesList;
    } else {
      throw Exception('Failed to load notes');
    }
  }

  // Method to create a new note
  Future<void> createNote(Note note) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(note.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create note');
    }
  }

  // Method to update an existing note
  Future<void> updateNote(Note note) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${note.id}'), // Replace with your API endpoint for updating a note
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(note.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update note');
    }
  }

  // Method to delete a note
  Future<void> deleteNote(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$id'), // Replace with your API endpoint for deleting a note
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete note');
    }
  }
}

class Note {
  final int id;
  final String title;
  final String content;

  Note({required this.id, required this.title, required this.content});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
