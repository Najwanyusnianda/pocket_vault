// lib/features/documents/presentation/widgets/edit_document/form_fields/enhanced_title_field.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../../../../shared/theme/form_design_system.dart';
import '../../../../../../shared/widgets/animated_form_field.dart';
import '../../../controllers/edit_document_controller.dart';

class EnhancedTitleField extends ConsumerStatefulWidget {
  final Document document;

  const EnhancedTitleField({
    super.key,
    required this.document,
  });

  @override
  ConsumerState<EnhancedTitleField> createState() => _EnhancedTitleFieldState();
}

class _EnhancedTitleFieldState extends ConsumerState<EnhancedTitleField> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    final editState = ref.read(editDocumentControllerProvider(widget.document));
    _controller = TextEditingController(text: editState.formData?.title ?? widget.document.title);
    
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editState = ref.watch(editDocumentControllerProvider(widget.document));
    final editController = ref.read(editDocumentControllerProvider(widget.document).notifier);
    
    return InteractiveFormField(
      child: AnimatedContainer(
        duration: FormDesignSystem.fastAnimation,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isFocused ? [
            BoxShadow(
              color: FormDesignSystem.sectionColors[FormSection.mainDetails]!
                  .withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ] : null,
        ),
        child: TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          style: FormDesignSystem.inputTextStyle(context),
          decoration: FormDesignSystem.enhancedInputDecoration(
            labelText: 'Document Title',
            prefixIcon: Icons.title,
            hintText: 'Enter a descriptive title...',
            helperText: 'Give your document a clear, descriptive name',
            section: FormSection.mainDetails,
            isFocused: _isFocused,
            hasError: editState.validation?.errors['title'] != null,
          ),
          onChanged: (value) {
            editController.updateTitle(value);
          },
          validator: (value) => editState.validation?.errors['title'],
          textInputAction: TextInputAction.next,
          maxLength: 100,
          buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
            return Text(
              '$currentLength${maxLength != null ? '/$maxLength' : ''}',
              style: FormDesignSystem.helperTextStyle(context),
            );
          },
        ),
      ),
    );
  }
}
