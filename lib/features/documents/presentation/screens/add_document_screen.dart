// lib/features/documents/presentation/screens/add_document_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_vault/core/database/app_database.dart';
import '../providers/document_providers.dart';
import 'package:drift/drift.dart' as drift;

class AddDocumentScreen extends ConsumerStatefulWidget {
  const AddDocumentScreen({super.key});

  @override
  ConsumerState<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends ConsumerState<AddDocumentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveDocument() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;

      final newDoc = DocumentsCompanion.insert(
        title: title,
        filePath: 'dummy/path', // Placeholder
        creationDate: DateTime.now(),
        updatedDate: DateTime.now(),
        isArchived: drift.Value(false),
        isFavorite: drift.Value(false),
      );

      ref.read(documentFormProvider.notifier).addDocument(newDoc).then((_) {
        if (mounted) {
          context.pop();
        }
      });
    }
  }

  // --- FIX IS HERE ---
  // The build method was missing. It must be inside the State class.
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(documentFormProvider, (_, state) {
      if (state is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${state.error}')),
        );
      }
    });

    final formState = ref.watch(documentFormProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Document'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Document Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: formState.isLoading ? null : _saveDocument,
                child: formState.isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Save Document'),
              )
            ],
          ),
        ),
      ),
    );
  }
}