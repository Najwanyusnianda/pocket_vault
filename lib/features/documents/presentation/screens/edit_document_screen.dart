// lib/features/documents/presentation/screens/edit_document_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../controllers/edit_document_controller.dart';
import '../controllers/edit_form_controller.dart';
import '../widgets/edit_document/edit_document_app_bar.dart';
import '../widgets/edit_document/edit_document_form.dart';

class EditDocumentScreen extends ConsumerWidget {
  final Document document;

  const EditDocumentScreen({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize controllers
    ref.watch(editDocumentControllerProvider(document));
    ref.watch(editFormControllerProvider(document));
    
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        
        final controller = ref.read(editDocumentControllerProvider(document).notifier);
        final canClose = await controller.handleBackNavigation(context);
        if (canClose && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: EditDocumentAppBar(document: document),
        body: SingleChildScrollView(
          child: EditDocumentForm(document: document),
        ),
      ),
    );
  }
}
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              ExpirationDatePicker(
                selectedDate: _expirationDate,
                onDateSelected: (date) {
                  setState(() {
                    _expirationDate = date;
                  });
                },

