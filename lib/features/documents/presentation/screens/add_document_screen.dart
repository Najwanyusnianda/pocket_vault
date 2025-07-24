// lib/features/documents/presentation/screens/add_document_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/models/document_type.dart';
import '../../../../core/services/file_picker_service.dart';
import '../controllers/document_form_controller.dart';
import '../widgets/add_document/document_form_widget.dart';
import '../widgets/add_document/save_button_widget.dart';
import '../helpers/form_helpers.dart';

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
    if (widget.fileResult != null) {
      _titleController.text = FormHelpers.getDisplayNameFromFile(widget.fileResult);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  // --- FIX: This method now only calls the controller. ---
  // It no longer awaits a result or handles navigation.
  Future<void> _saveDocument() async {
    // 1. Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // 2. Validate file (if provided)
    if (widget.fileResult != null) {
      final fileError = FormHelpers.validateFile(widget.fileResult);
      if (fileError != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(fileError)));
        return;
      }
    }

    // 3. Ensure file is provided
    if (widget.fileResult?.file == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No file selected')));
      return;
    }

    // 4. Call the controller to save the document. The listener will handle the result.
    await ref.read(documentFormControllerProvider.notifier).saveDocumentWithFile(
      title: _titleController.text,
      file: widget.fileResult!.file!,
      mainType: _selectedMainType,
      description: null,
      expirationDate: null,
      isFavorite: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // We still watch the provider to manage the loading state of the button
    final formState = ref.watch(documentFormControllerProvider);
    
    // --- FIX: Re-introduced ref.listen to handle side-effects correctly. ---
    // This is the correct place to handle navigation and SnackBars.
    ref.listen<AsyncValue<void>>(documentFormControllerProvider, (previous, next) {
      // Check if the state is transitioning from loading to a success or error state.
      if (previous is AsyncLoading) {
        next.when(
          data: (_) {
            // Success
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Document saved successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            // Use context.go('/') to safely navigate home from a top-level route.
            context.go('/');
          },
          error: (error, stack) {
            // Error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to save document: $error'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          },
          loading: () { /* Do nothing while still loading */ },
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Save Document'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          // Using context.pop() here is correct because the user is manually going back.
          onPressed: formState.isLoading ? null : () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          DocumentFormWidget(
            fileResult: widget.fileResult,
            formKey: _formKey,
            titleController: _titleController,
            selectedMainType: _selectedMainType,
            onMainTypeChanged: (type) {
              setState(() {
                _selectedMainType = type;
              });
            },
          ),
          
          // Save button positioned at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SaveButtonWidget(
              onPressed: _saveDocument,
              isLoading: formState.isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
