import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/provider/NotesProvider.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../reusable/NavBar.dart';


class Notes extends StatefulWidget {
  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {

List<String>colors=[];
  TextEditingController _editController = TextEditingController();
  TextEditingController _newItemController = TextEditingController();

  int _selectedIndex = -1;
  @override
  void initState() {

    super.initState();
    Provider.of<NotesProvider>(context,listen: false).fetchNotes();
  }

  void _editItem(int index) {
    _editController.text =   Provider.of<NotesProvider>(context,listen: false).notes.where((element) => element.id == index).first.content!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('edit note').tr(),
          content: TextField(
            controller: _editController,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {

                  Provider.of<NotesProvider>(context,listen: false).updateNote(Note(id: index,content: _editController.text)) ;

                Navigator.pop(context);
              },
              child: Text('save').tr(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('cancel').tr(),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int index) {
    Provider.of<NotesProvider>(context,listen: false).deleteNote(index);
  }

  void _addNewNote() {
    showDialog(
      barrierColor: Color(0xffE7EDFD),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('add note').tr(),
            content: TextField(
              controller: _newItemController,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<NotesProvider>(context,listen: false).createNote(Note(content: _newItemController.text));

                    _newItemController.clear();

                  Navigator.pop(context);
                },
                child: Text('add').tr(),
              ),
              ElevatedButton(
                onPressed: () {
                  _newItemController.clear();
                  Navigator.pop(context);
                },
                child: Text('cancel').tr(),
              ),
            ],

        );
      },
    );
  }

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xffE7EDFD),
        drawer: NavBar(),
        appBar: AppBar(
          leading: GestureDetector(  onTap: ()=>_scaffoldKey.currentState?.openDrawer(),child: Icon(Icons.menu,color: Colors.black,)),
          backgroundColor: Colors.white,
          title:  const Text('note',
            style: TextStyle(color: Colors.black),
          ).tr(),

        ),
        body:
        Consumer<NotesProvider>(
          builder:(context,notesProvider,child)=> ListView.builder(
            itemCount: notesProvider.notes.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: MediaQuery.of(context).size.height*0.3,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  elevation: 3,
                  child: ListTile(
                    title: Text(notesProvider.notes[index].content??""),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editItem(notesProvider.notes[index].id!);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteItem(notesProvider.notes[index].id!);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
              },
          ),
        ),
    floatingActionButton: FloatingActionButton(
    onPressed: _addNewNote,
    child: Icon(Icons.add),
    ),


      );

  }

  @override
  void dispose() {
    _editController.dispose();
    _newItemController.dispose();
    super.dispose();
  }
}




//