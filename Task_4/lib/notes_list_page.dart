import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'note.dart';
import 'notes_provider.dart';

class NotesListPage extends StatelessWidget {
  const NotesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes App")),
      body: Consumer<NotesProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Search notes...",
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: provider.search,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.notes.length,
                  itemBuilder: (context, index) {
                    final note = provider.notes[index];

                    return Dismissible(
                      key: Key(note.id),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete,
                            color: Colors.white),
                      ),
                      onDismissed: (_) {
                        provider.deleteNote(note.id);
                      },
                      child: ListTile(
                        title: Text(note.title),
                        subtitle: Text(note.description),
                        onTap: () {
                          _showDialog(context, provider,
                              isEdit: true, note: note);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context,
              Provider.of<NotesProvider>(context, listen: false));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDialog(BuildContext context,
      NotesProvider provider,
      {bool isEdit = false, Note? note}) {
    final titleController =
    TextEditingController(text: note?.title ?? '');
    final descController =
    TextEditingController(text: note?.description ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isEdit ? "Edit Note" : "Add Note"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController),
            TextField(controller: descController),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (isEdit) {
                provider.updateNote(
                  note!.id,
                  titleController.text,
                  descController.text,
                );
              } else {
                provider.addNote(
                  Note(
                    id: const Uuid().v4(),
                    title: titleController.text,
                    description: descController.text,
                    createdAt: DateTime.now(),
                  ),
                );
              }
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
