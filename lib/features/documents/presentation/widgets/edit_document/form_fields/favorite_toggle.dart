// lib/features/documents/presentation/widgets/edit_document/form_fields/favorite_toggle.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../controllers/edit_form_controller.dart';
import '../../../controllers/edit_form_state.dart';

class FavoriteToggle extends ConsumerWidget {
  final Document document;

  const FavoriteToggle({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the safe extension getter to access formData
    final formState = ref.watch(editFormControllerProvider(document));
    final isFavorite = formState.formData?.isFavorite ?? false;
    
    final formController = ref.read(editFormControllerProvider(document).notifier);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Favorite Document',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isFavorite 
                        ? 'This document will appear in your favorites.'
                        : 'Mark this document as a favorite for quick access.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Switch.adaptive(
              value: isFavorite,
              onChanged: (value) {
                // --- FIX: Corrected method name ---
                formController.updateFavoriteStatus(value);
                
                // Show feedback
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value 
                          ? 'Added to favorites' 
                          : 'Removed from favorites',
                    ),
                    duration: const Duration(milliseconds: 1500),
                    action: SnackBarAction(
                      label: 'Undo',
                      // --- FIX: Corrected method name in Undo action ---
                      onPressed: () => formController.updateFavoriteStatus(!value),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
