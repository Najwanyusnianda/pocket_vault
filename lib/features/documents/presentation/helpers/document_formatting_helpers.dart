// lib/features/documents/presentation/helpers/document_formatting_helpers.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';

/// Helper class for formatting document-related data for display
class DocumentFormattingHelpers {
  DocumentFormattingHelpers._();

  /// Formats a DateTime for display in document metadata
  static String formatDateTime(DateTime dateTime) {
    return DateFormat.yMMMd().add_Hm().format(dateTime);
  }

  /// Formats a date only (without time) for display
  static String formatDate(DateTime dateTime) {
    return DateFormat.yMMMd().format(dateTime);
  }

  /// Gets the display name for a file from its full path
  static String getFileDisplayName(String filePath) {
    return filePath.split('/').last;
  }

  /// Checks if a document is expiring soon (within 30 days)
  static bool isExpiringSoon(DateTime expirationDate) {
    final now = DateTime.now();
    final difference = expirationDate.difference(now).inDays;
    return difference <= 30 && difference >= 0;
  }

  /// Gets expiration status text with color coding
  static ExpirationStatus getExpirationStatus(DateTime? expirationDate) {
    if (expirationDate == null) {
      return ExpirationStatus(
        text: 'No expiration',
        color: Colors.grey,
        isUrgent: false,
      );
    }

    final now = DateTime.now();
    final difference = expirationDate.difference(now).inDays;

    if (difference < 0) {
      return ExpirationStatus(
        text: 'Expired ${(-difference)} days ago',
        color: Colors.red,
        isUrgent: true,
      );
    } else if (difference == 0) {
      return ExpirationStatus(
        text: 'Expires today',
        color: Colors.red,
        isUrgent: true,
      );
    } else if (difference == 1) {
      return ExpirationStatus(
        text: 'Expires tomorrow',
        color: Colors.orange,
        isUrgent: true,
      );
    } else if (difference <= 7) {
      return ExpirationStatus(
        text: 'Expires in $difference days',
        color: Colors.orange,
        isUrgent: true,
      );
    } else if (difference <= 30) {
      return ExpirationStatus(
        text: 'Expires in $difference days',
        color: Colors.amber,
        isUrgent: false,
      );
    } else {
      return ExpirationStatus(
        text: 'Expires ${formatDate(expirationDate)}',
        color: Colors.green,
        isUrgent: false,
      );
    }
  }

  /// Gets appropriate status badges for a document
  static List<DocumentBadge> getDocumentBadges(Document document) {
    final badges = <DocumentBadge>[];

    // Favorite badge
    if (document.isFavorite) {
      badges.add(DocumentBadge(
        icon: Icons.favorite,
        color: Colors.red,
        tooltip: 'Favorite',
      ));
    }

    // Expiration badge
    if (document.expirationDate != null) {
      final status = getExpirationStatus(document.expirationDate);
      if (status.isUrgent) {
        badges.add(DocumentBadge(
          icon: Icons.schedule,
          color: status.color,
          tooltip: status.text,
        ));
      }
    }

    // Archived badge (if applicable)
    if (document.isArchived) {
      badges.add(DocumentBadge(
        icon: Icons.archive,
        color: Colors.grey,
        tooltip: 'Archived',
      ));
    }

    return badges;
  }

  /// Formats file size for display
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

/// Data class for expiration status information
class ExpirationStatus {
  final String text;
  final Color color;
  final bool isUrgent;

  const ExpirationStatus({
    required this.text,
    required this.color,
    required this.isUrgent,
  });
}

/// Data class for document badges
class DocumentBadge {
  final IconData icon;
  final Color color;
  final String tooltip;

  const DocumentBadge({
    required this.icon,
    required this.color,
    required this.tooltip,
  });
}
