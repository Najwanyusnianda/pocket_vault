// lib/features/documents/presentation/screens/document_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Import the provider you created in the data layer step
import '../providers/document_providers.dart';

class DocumentListScreen extends ConsumerWidget {
  const DocumentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This is the magic link to your data layer.
    // Riverpod will handle loading states, error states, and updates automatically.
    final documentsAsyncValue = ref.watch(documentListStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PocketVault'),
      ),
      body: documentsAsyncValue.when(
        // The data is available, build the list
        data: (documents) {
          if (documents.isEmpty) {
            return const Center(
              // Good UX: Provide a helpful empty state
              child: Text(
                'No documents yet.\nTap the + button to add your first one!',
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final doc = documents[index];
              // TODO: In the next step, make this a custom DocumentCard widget
              return ListTile(
                leading: const Icon(Icons.description),
                title: Text(doc.title),
                subtitle: Text('Added on: {doc.creationDate.toLocal()}'),
                // TODO: Add onTap to navigate to a detail screen
              );
            },
          );
        },
        // The data is still loading, show a spinner
        loading: () => const Center(child: CircularProgressIndicator()),
        // An error occurred, show an error message
        error: (err, stack) => Center(child: Text('An error occurred: $err')),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // This is now active
            context.go('/add-document');
          },
          child: const Icon(Icons.add),
        ),
    );
  }
}
