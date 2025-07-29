// lib/features/documents/presentation/widgets/edit_document/cards/attributes_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../../../../shared/theme/form_design_system.dart';
import '../../../../../../shared/widgets/animated_form_field.dart';
import '../form_fields/main_type_dropdown.dart';
import '../form_fields/sub_type_dropdown.dart';
import '../form_fields/tags_field.dart';
import '../form_fields/expiration_date_picker.dart';

class AttributesCard extends ConsumerWidget {
  final Document document;

  const AttributesCard({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedFormField(
      delay: 300, // Second card with delay
      child: Container(
        margin: const EdgeInsets.only(bottom: FormDesignSystem.sectionSpacing),
        decoration: FormDesignSystem.sectionCardDecoration(
          context, 
          FormSection.attributes,
        ),
        child: Padding(
          padding: const EdgeInsets.all(FormDesignSystem.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Enhanced section header
              Row(
                children: [
                  FormDesignSystem.sectionIcon(FormSection.attributes),
                  const SizedBox(width: 12),
                  Text(
                    'Document Attributes',
                    style: FormDesignSystem.sectionHeaderStyle(
                      context, 
                      FormSection.attributes,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: FormDesignSystem.sectionSpacing),
              
              // Enhanced form fields with staggered animations
              AnimatedFormField(
                delay: 400,
                child: MainTypeDropdown(document: document),
              ),
              
              const SizedBox(height: FormDesignSystem.fieldSpacing),
              
              AnimatedFormField(
                delay: 500,
                child: SubTypeDropdown(document: document),
              ),
              
              const SizedBox(height: FormDesignSystem.fieldSpacing),
              
              AnimatedFormField(
                delay: 600,
                child: TagsField(document: document),
              ),
              
              const SizedBox(height: FormDesignSystem.fieldSpacing),
              
              AnimatedFormField(
                delay: 700,
                child: ExpirationDatePicker(document: document),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
