// lib/features/documents/presentation/widgets/document_detail/document_error_widget.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocumentErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final VoidCallback? onRetry;
  final bool showBackButton;

  const DocumentErrorWidget({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.onRetry,
    this.showBackButton = true,
  });

  /// Factory constructor for document not found error
  factory DocumentErrorWidget.notFound({
    VoidCallback? onRetry,
    bool showBackButton = true,
  }) {
    return DocumentErrorWidget(
      title: 'Document Not Found',
      message: 'The requested document could not be found. It may have been deleted or moved.',
      icon: Icons.search_off,
      onRetry: onRetry,
      showBackButton: showBackButton,
    );
  }

  /// Factory constructor for network error
  factory DocumentErrorWidget.network({
    VoidCallback? onRetry,
    bool showBackButton = true,
  }) {
    return DocumentErrorWidget(
      title: 'Connection Error',
      message: 'Unable to load document data. Please check your connection and try again.',
      icon: Icons.cloud_off,
      onRetry: onRetry,
      showBackButton: showBackButton,
    );
  }

  /// Factory constructor for generic error
  factory DocumentErrorWidget.generic({
    String? errorMessage,
    VoidCallback? onRetry,
    bool showBackButton = true,
  }) {
    return DocumentErrorWidget(
      title: 'Something went wrong',
      message: errorMessage ?? 'An unexpected error occurred while loading the document.',
      icon: Icons.error_outline,
      onRetry: onRetry,
      showBackButton: showBackButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Error icon
              Icon(
                icon ?? Icons.error_outline,
                size: 80,
                color: colorScheme.error,
              ),
              const SizedBox(height: 24),

              // Error title
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Error message
              Text(
                message,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha:0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Action buttons
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  // Retry button (if retry callback provided)
                  if (onRetry != null)
                    FilledButton.icon(
                      onPressed: onRetry,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                    ),

                  // Back button
                  if (showBackButton)
                    OutlinedButton.icon(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Go Back'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Simplified error widget for inline use
class InlineErrorWidget extends StatelessWidget {
  final String message;
  final IconData? icon;
  final VoidCallback? onRetry;

  const InlineErrorWidget({
    super.key,
    required this.message,
    this.icon,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.error_outline,
            size: 48,
            color: colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha:0.8),
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
