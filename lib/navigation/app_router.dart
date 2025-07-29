// lib/navigation/app_router.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_vault/core/database/app_database.dart';
import 'package:pocket_vault/core/services/file_picker_service.dart';
import 'package:pocket_vault/features/documents/presentation/screens/add_document_screen.dart';
import 'package:pocket_vault/features/documents/presentation/screens/document_detail_screen.dart';
import 'package:pocket_vault/features/documents/presentation/screens/document_list_screen.dart';
import 'package:pocket_vault/features/documents/presentation/screens/edit_document_screen.dart';
import 'package:pocket_vault/features/shell/presentation/screens/main_shell_screen.dart';
import 'package:pocket_vault/features/bundles/presentation/screens/bundles_screen.dart';
import 'package:pocket_vault/features/reminders/presentation/screens/reminders_screen.dart';
import 'package:pocket_vault/features/settings/presentation/screens/settings_screen.dart';

// Provider to make the router accessible throughout the app
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true, // Helpful for debugging navigation issues
    routes: [
      // ShellRoute wraps all main screens with the BottomNavigationBar
      ShellRoute(
        builder: (context, state, child) {
          return MainShellScreen(child: child);
        },
        routes: [
          // Main screens that will have the bottom navigation bar
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const DocumentListScreen(),
          ),
          GoRoute(
            path: '/bundles',
            name: 'bundles',
            builder: (context, state) => const BundlesScreen(),
          ),
          GoRoute(
            path: '/reminders',
            name: 'reminders',
            builder: (context, state) => const RemindersScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),

      // Top-level routes that do NOT show the bottom navigation bar
      GoRoute(
        path: '/add-document',
        name: 'addDocument',
        builder: (context, state) {
          // This screen requires a FilePickerResult to be passed.
          // We safely check if the 'extra' data exists and is the correct type.
          if (state.extra != null && state.extra is FilePickerResult) {
            final fileResult = state.extra as FilePickerResult;
            return AddDocumentScreen(fileResult: fileResult);
          }
          
          // If no file is provided, it's an invalid navigation attempt.
          // We redirect to the home screen as a safe fallback.
          // A more advanced implementation could show an error page.
          return const DocumentListScreen();
        },
      ),

      // Route for viewing a single document's details
      GoRoute(
        path: '/document/:id',
        name: 'documentDetail',
        builder: (context, state) {
          // Safely parse the document ID from the URL path parameter.
          final documentId = int.tryParse(state.pathParameters['id'] ?? '');
          if (documentId != null) {
            return DocumentDetailScreen(documentId: documentId);
          }
          // If the ID is invalid, fall back to the home screen.
          return const DocumentListScreen();
        },
        routes: [
          // Nested route for editing a document
          GoRoute(
            path: 'edit', // This will result in a URL like /document/123/edit
            name: 'editDocument',
            builder: (context, state) {
              // The Document object is passed as 'extra' to pre-fill the form.
              if (state.extra != null && state.extra is Document) {
                final document = state.extra as Document;
                return EditDocumentScreen(document: document);
              }
              // If no document is provided, fall back to the home screen.
              return const DocumentListScreen();
            },
          ),
        ],
      ),
    ],
  );
});
