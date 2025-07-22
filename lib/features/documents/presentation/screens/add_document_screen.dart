import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/app_database.dart';
import '../providers/document_providers.dart';
// Import your Main/Sub type models
import '../../../../core/database/models/document_type.dart';

class AddDocumentScreen extends ConsumerStatefulWidget {
  const AddDocumentScreen({super.key});

  @override
  ConsumerState<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends ConsumerState<AddDocumentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  // ... controllers for other fields (description, notes etc.)

  // For your main/sub type dropdowns
  MainType? _selectedMainType;
  SubType? _selectedSubType;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _saveDocument() async {
    if (_formKey.currentState!.validate()) {
      // Create a Drift "Companion" object to insert.
      // Use drift.Value() to explicitly set values.
      final newDocument = DocumentsCompanion(
        title: drift.Value(_titleController.text),
        mainType: drift.Value(_selectedMainType!),
        subType: drift.Value(_selectedSubType!),
        // IMPORTANT: For now, we use a placeholder for file paths.
        filePath: const drift.Value('placeholder/path'),
        creationDate: drift.Value(DateTime.now()),
        updatedDate: drift.Value(DateTime.now()),
      );

      // Get the repository from the provider and call the add method.
      // Use ref.read() for one-time actions inside functions.
      try {
        await ref.read(documentRepositoryProvider).addDocument(newDocument);
        // If successful, go back to the previous screen.
        if (mounted) context.pop(); 
      } catch (e) {
        // Handle error, show a snackbar, etc.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Document')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Document Title'),
              validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
            ),
            // TODO: Add Dropdowns for MainType and SubType here,
            // using the form providers we discussed to manage state.
            // TODO: Add other fields like expiration date picker.
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveDocument,
              child: const Text('Save Document'),
            )
          ],
        ),
      ),
    );
  }
}
