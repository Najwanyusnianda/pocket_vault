// lib/features/documents/presentation/helpers/document_type_helpers.dart

import 'package:flutter/material.dart';
import '../../../../core/database/models/document_type.dart';

// This extension adds helper methods directly to the MainType enum.
extension DocumentTypeHelpers on MainType? {

  IconData getIcon() {
    switch (this) {
      case MainType.identification:
        return Icons.badge_outlined;
      case MainType.vehicle:
        return Icons.directions_car_outlined;
      case MainType.financial:
        return Icons.account_balance_wallet_outlined;
      case MainType.travel:
        return Icons.flight_outlined;
      case MainType.legal:
        return Icons.gavel_outlined;
      case MainType.medical:
        return Icons.local_hospital_outlined;
      case MainType.other:
      case null:
        return Icons.description_outlined;
    }
  }

  Color getColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (this) {
      case MainType.identification:
        return colorScheme.primary;
      case MainType.vehicle:
        return colorScheme.secondary;
      case MainType.financial:
        return colorScheme.tertiary;
      case MainType.travel:
        return Colors.orange.shade700; // Using a specific brand-like color is ok sometimes
      case MainType.legal:
        return Colors.purple.shade600;
      case MainType.medical:
        return colorScheme.error;
      case MainType.other:
      case null:
        return colorScheme.outline;
    }
  }

  String getName() {
    switch (this) {
      case MainType.identification:
        return 'Identification';
      case MainType.vehicle:
        return 'Vehicle';
      case MainType.financial:
        return 'Financial';
      case MainType.travel:
        return 'Travel';
      case MainType.legal:
        return 'Legal';
      case MainType.medical:
        return 'Medical';
      case MainType.other:
      case null:
        return 'Document';
    }
  }
}
