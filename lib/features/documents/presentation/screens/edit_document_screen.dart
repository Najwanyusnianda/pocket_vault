// lib/features/documents/presentation/screens/edit_document_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../controllers/edit_document_controller.dart';
import '../widgets/edit_document/edit_document_app_bar.dart';
import '../widgets/edit_document/edit_document_form.dart';

// This is necessary to correctly handle the PopScope logic and lifecycle.
class EditDocumentScreen extends ConsumerStatefulWidget {
  final Document document;

  const EditDocumentScreen({
    super.key,
    required this.document,
  });

  @override
  ConsumerState<EditDocumentScreen> createState() => _EditDocumentScreenState();
}

class _EditDocumentScreenState extends ConsumerState<EditDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    // The child widgets (AppBar and Form) are now responsible
    // for watching the providers they need.

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        
        // --- FIX: Capture the Navigator before the async gap ---
        final navigator = Navigator.of(context);
        
        final controller = ref.read(editDocumentControllerProvider(widget.document).notifier);
        final canClose = await controller.handleBackNavigation(context);
        
        // The 'mounted' check is still good practice here.
        if (canClose && mounted) {
          // Use the captured navigator.
          navigator.pop();
        }
      },
      child: Scaffold(
        // Pass the document down to the children. They will handle the providers.
        appBar: EditDocumentAppBar(document: widget.document),
        body: SingleChildScrollView(
          // The form logic is now encapsulated in its own widget.
          child: EditDocumentForm(document: widget.document),
        ),
      ),
    );
  }
}
