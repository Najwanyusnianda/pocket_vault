// In lib/navigation/app_router.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_vault/features/documents/presentation/screens/document_list_screen.dart';
import 'package:pocket_vault/features/documents/presentation/screens/add_document_screen.dart';

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
        path: '/add-document', // This path already exists
        builder: (context, state) => const AddDocumentScreen(), // Add the screen here
      ),

      // Add other routes here as you build them
    ],
  );
});