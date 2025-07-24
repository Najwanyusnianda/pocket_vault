// lib/features/documents/presentation/screens/document_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../providers/document_providers.dart';
import '../controllers/document_detail_controller.dart';
import '../widgets/document_detail/file_viewer_widget.dart';
import '../widgets/document_detail/document_detail_sheet.dart';
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
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        // Handle system back button with same safety checks
        if (!didPop) {
          _handleBackNavigation(context);
        }
      },
      child: Scaffold(
        // Transparent app bar that extends behind the body
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          automaticallyImplyLeading: false, // Disable default back button
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => _handleBackNavigation(context),
            ),
          ),
        ),
        body: Stack(
          children: [
            // Layer 1: Full-screen File Viewer (Background)
            Positioned.fill(
              child: FileViewerWidget(
                document: document,
                isFullScreen: true,
               // height: double.infinity, // Fill entire screen
              ),
            ),
            
            // Layer 2: Draggable Sheet (Foreground)
            DraggableScrollableSheet(
              initialChildSize: 0.25,
              minChildSize: 0.15,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return DocumentDetailSheet(
                  document: document,
                  scrollController: scrollController,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleBackNavigation(BuildContext context) {
    // Add a micro delay to avoid navigation assertion errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        // Use GoRouter's context.pop() for safer navigation
        if (context.mounted && context.canPop()) {
          context.pop();
        } else {
          // Fallback to home route if we can't pop
          if (context.mounted) {
            context.go('/');
          }
        }
      } catch (e) {
        // Extra safety: if GoRouter fails, use Navigator as fallback
        if (context.mounted) {
          Navigator.of(context).maybePop();
        }
      }
    });
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
