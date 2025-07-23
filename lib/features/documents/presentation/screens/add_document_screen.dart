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
import '../helpers/document_type_helpers.dart';

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
  final _descriptionController = TextEditingController();
  
  MainType? _selectedMainType;
  DateTime? _expirationDate;
  bool _isFavorite = false;

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
    _descriptionController.dispose();
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
        title: const Text('Add Document'),
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
                _buildFilePreview(),
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
              _buildTypeSelector(),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  hintText: 'Add notes or description',
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 16),

              // Expiration date
              _buildExpirationDatePicker(),
              const SizedBox(height: 16),

              // Favorite toggle
              SwitchListTile(
                title: const Text('Mark as Favorite'),
                subtitle: const Text('Quick access from favorites'),
                value: _isFavorite,
                onChanged: (value) {
                  setState(() {
                    _isFavorite = value;
                  });
                },
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilePreview() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final filePickerService = FilePickerService();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          // File icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              filePickerService.isPdfFile(widget.fileResult?.fileExtension)
                  ? Icons.picture_as_pdf
                  : Icons.image,
              color: colorScheme.onPrimaryContainer,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          // File info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.fileResult?.fileName ?? 'Unknown file',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  _getFileTypeDisplay(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSelector() {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Document Type',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: MainType.values.map((type) {
            final isSelected = _selectedMainType == type;
            return FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    type.getIcon(),
                    size: 16,
                    color: isSelected
                        ? theme.colorScheme.onSecondaryContainer
                        : type.getColor(context),
                  ),
                  const SizedBox(width: 4),
                  Text(type.getName()),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedMainType = selected ? type : null;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildExpirationDatePicker() {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: _selectExpirationDate,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Expiration Date (Optional)',
          suffixIcon: Icon(Icons.calendar_today),
        ),
        child: Text(
          _expirationDate != null
              ? '${_expirationDate!.day}/${_expirationDate!.month}/${_expirationDate!.year}'
              : 'Tap to select date',
          style: _expirationDate != null
              ? null
              : TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
        ),
      ),
    );
  }

  String _getFileTypeDisplay() {
    final extension = widget.fileResult?.fileExtension;
    if (extension == null) return 'Unknown format';
    
    final filePickerService = FilePickerService();
    if (filePickerService.isPdfFile(extension)) {
      return 'PDF Document';
    } else if (filePickerService.isImageFile(extension)) {
      return 'Image (${extension.toUpperCase()})';
    }
    return extension.toUpperCase();
  }

  Future<void> _selectExpirationDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _expirationDate ?? DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );

    if (date != null) {
      setState(() {
        _expirationDate = date;
      });
    }
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
        description: drift.Value(
          _descriptionController.text.trim().isEmpty 
              ? null 
              : _descriptionController.text.trim()
        ),
        filePath: drift.Value(savedFilePath),
        mainType: drift.Value(_selectedMainType),
        creationDate: drift.Value(DateTime.now()),
        updatedDate: drift.Value(DateTime.now()),
        expirationDate: drift.Value(_expirationDate),
        isFavorite: drift.Value(_isFavorite),
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