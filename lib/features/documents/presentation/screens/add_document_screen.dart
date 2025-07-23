// lib/features/documents/presentation/screens/add_document_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/models/document_type.dart';
import '../../../../core/services/file_picker_service.dart';
import '../providers/document_providers.dart';
import '../widgets/add_document/document_type_selector.dart';
import '../widgets/add_document/file_preview_widget.dart';

class AddDocumentScreen extends ConsumerStatefulWidget {
  final FilePickerResult? fileResult;

  const AddDocumentScreen({
    super.key,
    this.fileResult,
  });

  @override
  ConsumerState<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends ConsumerState<AddDocumentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  
  MainType? _selectedMainType;

  @override
  void initState() {
    super.initState();
    // Pre-fill the title with the filename (without extension)
    if (widget.fileResult?.fileName != null) {
      final filePickerService = FilePickerService();
      _titleController.text = filePickerService.getDisplayName(widget.fileResult!.fileName!);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Listen to the add document state
    ref.listen<AsyncValue<void>>(documentFormProvider, (_, state) {
      if (state is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${state.error}'),
            backgroundColor: colorScheme.error,
          ),
        );
      } else if (state.hasValue) {
        // Successfully added
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Document saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

    final addDocumentState = ref.watch(documentFormProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Save Document'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: addDocumentState.isLoading ? null : _saveDocument,
            child: addDocumentState.isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // File preview (only if file is provided)
              if (widget.fileResult != null) ...[
                FilePreviewWidget(fileResult: widget.fileResult!),
                const SizedBox(height: 24),
              ],

              // Document title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Document Title *',
                  hintText: 'Enter a descriptive title',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),

              // Document type selector
              DocumentTypeSelector(
                selectedType: _selectedMainType,
                onTypeSelected: (type) {
                  setState(() {
                    _selectedMainType = type;
                  });
                },
              ),
              const SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveDocument() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      String savedFilePath = 'no-file'; // Default for manual entry
      
      // Handle file saving if a file was provided
      if (widget.fileResult?.file != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final documentsDir = Directory(p.join(appDir.path, 'documents'));
        if (!await documentsDir.exists()) {
          await documentsDir.create(recursive: true);
        }

        // Generate unique filename
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final originalExtension = widget.fileResult!.fileExtension ?? 'tmp';
        final savedFileName = '${timestamp}_document.$originalExtension';
        final savedFile = File(p.join(documentsDir.path, savedFileName));

        // Copy file
        await widget.fileResult!.file!.copy(savedFile.path);
        savedFilePath = savedFile.path;
      }

      // Create document companion for database
      final document = DocumentsCompanion(
        title: drift.Value(_titleController.text.trim()),
        description: const drift.Value(null), // No description in quicksave
        filePath: drift.Value(savedFilePath),
        mainType: drift.Value(_selectedMainType),
        creationDate: drift.Value(DateTime.now()),
        updatedDate: drift.Value(DateTime.now()),
        expirationDate: const drift.Value(null), // No expiration in quicksave
        isFavorite: const drift.Value(false), // Not favorite by default
        isArchived: const drift.Value(false),
      );

      // Save to database using the provider
      await ref.read(documentFormProvider.notifier).addDocument(document);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save document: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}