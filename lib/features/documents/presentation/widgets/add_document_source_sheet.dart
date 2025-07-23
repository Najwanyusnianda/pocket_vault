// lib/features/documents/presentation/widgets/add_document_source_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/add_document_controller.dart';

class AddDocumentSourceSheet extends ConsumerWidget {
  const AddDocumentSourceSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle indicator
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Add Document',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Take Photo option
            _buildOption(
              context: context,
              icon: Icons.camera_alt_outlined,
              title: 'Take Photo',
              subtitle: 'Capture with camera',
              onTap: () {
                debugPrint('📸 [BottomSheet] Take Photo tapped');
                // 1. Call the controller
                ref.read(addDocumentControllerProvider.notifier).takePhoto();
                // 2. Close the sheet
                Navigator.pop(context);
              },
            ),
            
            // Divider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                height: 1,
                color: colorScheme.outline.withOpacity(0.2),
              ),
            ),

            // Choose File option
            _buildOption(
              context: context,
              icon: Icons.folder_open_outlined,
              title: 'Choose File',
              subtitle: 'Images or PDF files',
              onTap: () {
                debugPrint('📁 [BottomSheet] Choose File tapped');
                // 1. Call the controller
                ref.read(addDocumentControllerProvider.notifier).chooseFile();
                // 2. Close the sheet
                Navigator.pop(context);
              },
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Your existing _buildOption widget remains here, unchanged.
  Widget _buildOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    // ... (Your existing implementation)
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: colorScheme.onPrimaryContainer,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: colorScheme.onSurface.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
