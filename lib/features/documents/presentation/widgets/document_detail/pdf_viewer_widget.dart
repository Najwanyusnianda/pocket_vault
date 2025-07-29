// lib/features/documents/presentation/widgets/document_detail/pdf_viewer_widget.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class PdfViewerWidget extends StatefulWidget {
  final String filePath;
  final String documentTitle;
  final double? height;
  final bool isFullScreen;

  const PdfViewerWidget({
    super.key,
    required this.filePath,
    required this.documentTitle,
    this.height = 400,
    this.isFullScreen = false,
  });

  @override
  State<PdfViewerWidget> createState() => _PdfViewerWidgetState();
}

class _PdfViewerWidgetState extends State<PdfViewerWidget> {
  PdfViewerController? _controller;
  int _currentPage = 1;
  int _totalPages = 0;
  bool _isReady = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = PdfViewerController();
  }

  @override
  void dispose() {
    // PdfViewerController doesn't have dispose method in pdfrx 2.0.4
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Check if file exists
    if (!File(widget.filePath).existsSync()) {
      return Container(
        height: widget.isFullScreen ? null : widget.height,
        margin: widget.isFullScreen ? EdgeInsets.zero : const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: widget.isFullScreen ? BorderRadius.zero : BorderRadius.circular(12),
          border: widget.isFullScreen ? null : Border.all(color: colorScheme.outline.withValues(alpha:0.2)),
        ),
        child: const Center(
          child: Text('PDF file not found'),
        ),
      );
    }

    final pdfViewer = _errorMessage != null
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Error loading PDF',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  _errorMessage!,
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : PdfViewer.file(
            widget.filePath,
            controller: _controller,
            params: PdfViewerParams(
              maxScale: 8.0,
              minScale: 0.1,
              panAxis: PanAxis.free,
              boundaryMargin: widget.isFullScreen ? EdgeInsets.zero : const EdgeInsets.all(16.0),
              textSelectionParams: const PdfTextSelectionParams(
                enabled: true,
              ),
              onDocumentChanged: (document) {
                setState(() {
                  _totalPages = document?.pages.length ?? 0;
                  _isReady = true;
                });
              },
              onPageChanged: (pageNumber) {
                setState(() {
                  _currentPage = pageNumber ?? 1;
                });
              },
            ),
          );

  if (widget.isFullScreen) {
    // Full-screen mode with proper safe area handling
    return Column(
      children: [
        // ✅ FIX: Wrap control bar in SafeArea
        SafeArea(
          bottom: false, // Don't add bottom padding - let PDF extend to bottom
          child: _buildControlBar(context, theme, colorScheme),
        ),
        Expanded(child: pdfViewer),
      ],
    );
  }

    // Regular mode: with container wrapper
    return Container(
      height: widget.height,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha:0.2),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [

            // PDF Controls
            _buildControlBar(context, theme, colorScheme),
            // PDF Viewer
            Expanded(child: pdfViewer),
          ],
        ),
      ),
    );
  }

  Widget _buildControlBar(BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha:0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf, color: Colors.red, size: 20),
          const SizedBox(width: 8),
          
          Expanded(
            child: Text(
              !_isReady 
                ? 'Loading PDF...'
                : _totalPages > 0 
                  ? 'Page $_currentPage of $_totalPages'
                  : 'PDF loaded',
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          
          // Navigation buttons
          if (_totalPages > 1 && _controller != null) ...[
            IconButton(
              onPressed: _currentPage > 1 
                ? () => _controller!.goToPage(pageNumber: _currentPage - 1)
                : null,
              icon: const Icon(Icons.keyboard_arrow_left),
              tooltip: 'Previous page',
              iconSize: 20,
            ),
            IconButton(
              onPressed: _currentPage < _totalPages 
                ? () => _controller!.goToPage(pageNumber: _currentPage + 1)
                : null,
              icon: const Icon(Icons.keyboard_arrow_right),
              tooltip: 'Next page',
              iconSize: 20,
            ),
          ],
          
          // Page jump input
          if (_totalPages > 1 && _controller != null) ...[
            const SizedBox(width: 8),
            SizedBox(
              width: 50,
              height: 32,
              child: TextField(
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  border: OutlineInputBorder(),
                  hintText: 'Go',
                ),
                style: theme.textTheme.bodySmall,
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  final page = int.tryParse(value);
                  if (page != null && page >= 1 && page <= _totalPages) {
                    _controller!.goToPage(pageNumber: page);
                  }
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}