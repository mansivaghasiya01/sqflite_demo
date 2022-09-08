// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sqflite_todo_app/database/listDatabase.dart';
import 'package:sqflite_todo_app/model/listData_model.dart';
import 'package:sqflite_todo_app/view/details_page.dart';
import 'package:sqflite_todo_app/view/edit_page.dart';
import 'package:sqflite_todo_app/widget/card_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<ListData> listData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  // @override
  // void dispose() {
  //   ListDatabase.instance.close();

  //   super.dispose();
  // }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    listData = await ListDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Lists (data: ${listData.length})',
            style: TextStyle(fontSize: 24),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : listData.isEmpty
                  ? const Text(
                      'No data',
                      style: TextStyle(fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 5,
        ),
        itemCount: listData.length,
        itemBuilder: (context, index) {
          final list = listData[index];
          return GestureDetector(
            onTap: () async {
              print(listData[index]);
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NoteDetailPage(noteId: list.id!),
                ),
              );
              refreshNotes();
            },
            child: NoteCardWidget(listData: list, index: index),
          );
        },
      );
}
