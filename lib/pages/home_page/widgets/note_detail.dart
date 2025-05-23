import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../common/custom_appbar.dart';
import '../../../controllers/note_controller.dart';
import '../../../core/app_colors.dart';
import '../../../model/note_model.dart';

class NoteDetailPage extends StatelessWidget {
  final NoteController notesController = Get.put(NoteController());

  NoteDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final note = GoRouterState.of(context).extra as Note;
    final String noteId = note.id.toString();

    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        actions: [
          IconButton.outlined(
            onPressed: () => showUpdateNoteDialog(context, note),
            icon: const Icon(Icons.update),
            tooltip: 'Update',
          ),
          IconButton.outlined(
            onPressed: () {
              notesController.deleteNote(noteId);
              context.pop(); 
            },
            icon: const Icon(Icons.delete),
            tooltip: 'Delete',
          ),
        ],
      ),
      body: StreamBuilder<Note>(
        stream: notesController.getNoteById(noteId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: blackColor));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Note not found'));
          }

          final note = snapshot.data!;
          final formattedDate = DateFormat(
            'dd MMMM yyyy',
          ).format(note.createdAt);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Created on: $formattedDate',
                  style: TextStyle(fontSize: 15, color: blackColor),
                ),
                const SizedBox(height: 20),
                Text(
                  note.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  note.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18, color: blackColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showUpdateNoteDialog(BuildContext context, Note note) {
    notesController.titleController.text = note.title;
    notesController.descriptionController.text = note.description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Note'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: notesController.titleController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: notesController.descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  maxLines: null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                notesController.titleController.clear();
                notesController.descriptionController.clear();
                context.pop(); 
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedNote = Note(
                  id: note.id,
                  title: notesController.titleController.text,
                  description: notesController.descriptionController.text,
                  createdAt: note.createdAt,
                );
                notesController.updateNote(updatedNote);
                context.pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
