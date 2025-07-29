// lib/features/documents/presentation/widgets/edit_document/cards/main_details_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../../../../shared/theme/form_design_system.dart';
import '../../../../../../shared/widgets/animated_form_field.dart';
import '../form_fields/title_field.dart';
import '../form_fields/description_field.dart';

class MainDetailsCard extends ConsumerWidget {
  final Document document;

  const MainDetailsCard({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedFormField(
      delay: 0, // First card, no delay
      child: Container(
        margin: const EdgeInsets.only(bottom: FormDesignSystem.sectionSpacing),
        decoration: FormDesignSystem.sectionCardDecoration(
          context, 
          FormSection.mainDetails,
        ),
        child: Padding(
          padding: const EdgeInsets.all(FormDesignSystem.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Enhanced section header with icon and better typography
              Row(
                children: [
                  FormDesignSystem.sectionIcon(FormSection.mainDetails),
                  const SizedBox(width: 12),
                  Text(
                    'Document Details',
                    style: FormDesignSystem.sectionHeaderStyle(
                      context, 
                      FormSection.mainDetails,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: FormDesignSystem.sectionSpacing),
              
              // Enhanced form fields with staggered animations
              AnimatedFormField(
                delay: 100,
                child: TitleField(document: document),
              ),
              
              const SizedBox(height: FormDesignSystem.fieldSpacing),
              
              AnimatedFormField(
                delay: 200,
                child: DescriptionField(document: document),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
