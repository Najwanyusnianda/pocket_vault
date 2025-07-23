// In lib/navigation/app_router.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_vault/features/documents/presentation/screens/document_list_screen.dart';
import 'package:pocket_vault/features/documents/presentation/screens/add_document_screen.dart';
import 'package:pocket_vault/features/documents/presentation/screens/document_detail_screen.dart';
import 'package:pocket_vault/features/documents/presentation/screens/edit_document_screen.dart';
import 'package:pocket_vault/core/services/file_picker_service.dart';
import 'package:pocket_vault/core/database/app_database.dart';

// Create a provider for your router
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const DocumentListScreen(),
      ),
      GoRoute(
        path: '/add-document',
        builder: (context, state) {
          // 🔍 DEBUGGING: Log navigation details
          debugPrint('🏗️ [Router] Navigated to /add-document. Extra is: ${state.extra}');
          
          final fileResult = state.extra as FilePickerResult?;
          if (fileResult != null) {
            debugPrint('🏗️ [Router] File found: ${fileResult.fileName}');
            return AddDocumentScreen(fileResult: fileResult);
          }
          
          // Handle case where file is null - could be manual entry
          debugPrint('🏗️ [Router] No file provided, creating empty screen');
          return const AddDocumentScreen(fileResult: null);
        },
      ),

      GoRoute(
        path: '/document/:id',
        builder: (context, state) {
          final documentId = int.parse(state.pathParameters['id']!);
          return DocumentDetailScreen(documentId: documentId);
        },
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) {
              final document = state.extra as Document;
              return EditDocumentScreen(document: document);
            },
          ),
        ],
      ),

      // Add other routes here as you build them
    ],
  );
});