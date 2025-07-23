// lib/features/documents/presentation/screens/document_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../providers/document_providers.dart';
import '../controllers/document_detail_controller.dart';
import '../widgets/document_detail/document_detail_app_bar.dart';
import '../widgets/document_detail/file_viewer_widget.dart';
import '../widgets/document_detail/document_metadata_widget.dart';
import '../widgets/document_detail/document_error_widget.dart';

class DocumentDetailScreen extends ConsumerWidget {
  final int documentId;

  const DocumentDetailScreen({
    super.key,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentAsync = ref.watch(singleDocumentProvider(documentId));
    
    // Listen for controller state changes
    ref.listen<DocumentDetailState>(
      documentDetailControllerProvider(documentId),
      (previous, next) {
        if (next.isError) {
          _showErrorMessage(context, next.errorMessage!);
        }
      },
    );
    
    return documentAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => DocumentErrorWidget.generic(
        errorMessage: error.toString(),
        onRetry: () => ref.invalidate(singleDocumentProvider(documentId)),
      ),
      data: (document) => _buildDetailScreen(context, ref, document),
    );
  }

  Widget _buildDetailScreen(BuildContext context, WidgetRef ref, Document document) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with actions
          DocumentDetailAppBar(document: document),

          // File Viewer
          SliverToBoxAdapter(
            child: FileViewerWidget(document: document),
          ),

          // Document Metadata
          SliverToBoxAdapter(
            child: DocumentMetadataWidget(document: document),
          ),

          // Add some bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
        ],
      ),
    );
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
