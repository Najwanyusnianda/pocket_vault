// lib/features/documents/presentation/widgets/edit_document/form_fields/archive_toggle.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../controllers/edit_document_controller.dart';

class ArchiveToggle extends ConsumerWidget {
  final Document document;

  const ArchiveToggle({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editDocumentControllerProvider(document));
    final editController = ref.read(editDocumentControllerProvider(document).notifier);
    
    final isArchived = editState.formData?.isArchived ?? false;
    
    return ListTile(
      leading: Icon(
        isArchived ? Icons.archive : Icons.archive_outlined,
        color: isArchived ? Colors.orange : null,
      ),
      title: const Text('Archive Document'),
      subtitle: Text(
        isArchived 
            ? 'Document is archived and hidden from main list'
            : 'Archive to hide from main list without deleting',
      ),
      trailing: Switch(
        value: isArchived,
        onChanged: (bool value) {
          editController.updateArchiveStatus(value);
        },
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
