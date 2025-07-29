// lib/features/documents/presentation/widgets/edit_document/test_edit_form.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/database/app_database.dart';
import '../../../../../core/database/models/document_type.dart';
import 'edit_document_form.dart';

/// Test widget to showcase the new card-based edit form
class TestEditForm extends ConsumerWidget {
  const TestEditForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create a sample document for testing
    final sampleDocument = Document(
      id: 1,
      title: "Sample Passport",
      description: "My personal passport document",
      filePath: "/path/to/document.pdf",
      mainType: MainType.identification,
      subType: SubType.passport,
      tags: "travel, official, 2025",
      customFields: '{"passportNumber": "A12345678", "country": "United States"}',
      creationDate: DateTime.now(),
      updatedDate: DateTime.now(),
      expirationDate: DateTime.now().add(const Duration(days: 365 * 5)),
      isFavorite: true,
      isArchived: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Document - Card Layout'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      ),
      body: EditDocumentForm(document: sampleDocument),
    );
  }
}
