import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notebook/core/app_colors.dart';

import '../../../common/common_button.dart';
import '../../../common/custom_appbar.dart';
import '../../../controllers/note_controller.dart';
import '../../ultils/Uitilities.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key}); // Fetch the NotesController

  @override
  Widget build(BuildContext context) {
    final NoteController addNotesController = NoteController.instance;
    final Utils utils = Utils();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Note'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField for the Title
            TextFormField(
              controller: addNotesController.titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // TextField for the Description
            TextFormField(
              controller: addNotesController.descriptionController,
              onTapOutside:
                  (event) => FocusManager.instance.primaryFocus!.unfocus(),
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            // Save Button
            CommonButton(
              onTap: () {
                // Check if title or description is empty
                if (addNotesController.titleController.text.isEmpty ||
                    addNotesController.descriptionController.text.isEmpty) {
                  utils.toastMessage(message: 'Please fill in all fields');
                } else {
                  addNotesController.addNote();
                  context.pop();
                  utils.toastMessage(
                    message: 'Note added successfully',
                    color: greenColor,
                  );
                }
              },
              text: 'Save Note',
            ),
          ],
        ),
      ),
    );
  }
}
