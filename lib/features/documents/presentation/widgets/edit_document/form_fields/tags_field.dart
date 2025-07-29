// lib/features/documents/presentation/widgets/edit_document/form_fields/tags_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../controllers/edit_document_controller.dart';

class TagsField extends ConsumerStatefulWidget {
  final Document document;

  const TagsField({
    super.key,
    required this.document,
  });

  @override
  ConsumerState<TagsField> createState() => _TagsFieldState();
}

class _TagsFieldState extends ConsumerState<TagsField> {
  late TextEditingController _tagsController;

  @override
  void initState() {
    super.initState();
    final editState = ref.read(editDocumentControllerProvider(widget.document));
    _tagsController = TextEditingController(
      text: editState.formData?.tags ?? '',
    );
  }

  @override
  void dispose() {
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editController = ref.read(editDocumentControllerProvider(widget.document).notifier);
    
    return TextFormField(
      controller: _tagsController,
      decoration: const InputDecoration(
        labelText: 'Tags',
        hintText: 'Enter tags separated by commas (e.g., work, 2025, taxes)',
        prefixIcon: Icon(Icons.label_outline),
        border: OutlineInputBorder(),
        helperText: 'Use tags to organize and find documents easily',
      ),
      maxLines: 2,
      onChanged: (value) {
        editController.updateTags(value);
      },
    );
  }
}
