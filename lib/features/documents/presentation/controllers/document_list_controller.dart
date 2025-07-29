// lib/features/documents/presentation/controllers/document_list_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_debounce/easy_debounce.dart';
import '../../data/models/document_filter.dart';
import '../providers/document_providers.dart';

/// State class for document list screen
class DocumentListState {
  final bool isSearching;
  final String searchQuery;
  final DocumentFilter filter;
  final bool isLoading;
  final String? error;

  const DocumentListState({
    this.isSearching = false,
    this.searchQuery = '',
    this.filter = const DocumentFilter(),
    this.isLoading = false,
    this.error,
  });

  DocumentListState copyWith({
    bool? isSearching,
    String? searchQuery,
    DocumentFilter? filter,
    bool? isLoading,
    String? error,
  }) {
    return DocumentListState(
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

/// Controller for managing document list screen state and actions
class DocumentListController extends StateNotifier<DocumentListState> {
  final Ref _ref;

  DocumentListController(this._ref) : super(const DocumentListState());

  /// Toggle search mode on/off
  void toggleSearch() {
    if (state.isSearching) {
      // Exit search mode
      clearSearch();
      state = state.copyWith(isSearching: false);
    } else {
      // Enter search mode
      state = state.copyWith(isSearching: true);
    }
  }

  /// Update search query with debouncing
  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    
    // Update the provider with debouncing
    EasyDebounce.debounce(
      'document_search',
      const Duration(milliseconds: 300),
      () {
        _ref.read(documentSearchQueryProvider.notifier).state = query;
      },
    );
  }

  /// Clear search query and exit search mode
  void clearSearch() {
    state = state.copyWith(
      searchQuery: '',
      isSearching: false,
    );
    _ref.read(documentSearchQueryProvider.notifier).state = '';
    EasyDebounce.cancel('document_search');
  }

  /// Update document filter
  void updateFilter(DocumentFilter filter) {
    state = state.copyWith(filter: filter);
    _ref.read(documentFilterStateProvider.notifier).state = filter;
  }

  /// Clear all filters
  void clearFilters() {
    const emptyFilter = DocumentFilter();
    state = state.copyWith(filter: emptyFilter);
    _ref.read(documentFilterStateProvider.notifier).state = emptyFilter;
  }

  /// Set loading state
  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  /// Set error state
  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  /// Handle refresh action
  void refreshDocuments() {
    // Invalidate the filtered document list to trigger refresh
    _ref.invalidate(filteredDocumentListProvider);
  }

  /// Dispose resources
  @override
  void dispose() {
    EasyDebounce.cancelAll();
    super.dispose();
  }
}

/// Provider for document list controller
final documentListControllerProvider = StateNotifierProvider<DocumentListController, DocumentListState>((ref) {
  return DocumentListController(ref);
});
