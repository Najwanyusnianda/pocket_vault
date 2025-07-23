import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';

// Import the provider you created in the data layer step
import '../providers/document_providers.dart';
import '../controllers/add_document_controller.dart';
import '../widgets/document_list/document_list_item.dart';
import '../widgets/document_list/filter_bottom_sheet.dart';
import '../widgets/add_document/add_document_source_sheet.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../core/services/file_picker_service.dart';
import '../../data/models/document_filter.dart';

class DocumentListScreen extends ConsumerStatefulWidget {
  const DocumentListScreen({super.key});

  @override
  ConsumerState<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends ConsumerState<DocumentListScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    EasyDebounce.cancelAll();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
    });

    if (_isSearching) {
      _searchFocusNode.requestFocus();
    } else {
      _searchController.clear();
      ref.read(documentSearchQueryProvider.notifier).state = '';
      _searchFocusNode.unfocus();
    }
  }

  void _onSearchChanged(String query) {
    EasyDebounce.debounce(
      'search-documents',
      const Duration(milliseconds: 300),
      () {
        ref.read(documentSearchQueryProvider.notifier).state = query;
      },
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔍 DEBUGGING: Listen to the add document controller state
    ref.listen<AsyncValue<FilePickerResult?>>(addDocumentControllerProvider, (previous, next) {
      debugPrint('👂 [Listener] State changed: $next');
      
      // Handle loading state
      if (next is AsyncLoading) {
        debugPrint('⏳ [Listener] Loading state - showing dialog');
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } 
      // Handle success state
      else if (next is AsyncData && next.value != null) {
        // Dismiss loading dialog if showing
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        debugPrint('🚀 [Listener] Navigating to /add-document with file: ${next.value?.fileName}');
        context.go('/add-document', extra: next.value);
      } 
      // Handle error state
      else if (next is AsyncError) {
        // Dismiss loading dialog if showing
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        debugPrint('❌ [Listener] Error received: ${next.error}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${next.error}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });

    // This is the magic link to your data layer.
    // Riverpod will handle loading states, error states, and updates automatically.
    final documentsAsyncValue = ref.watch(filteredDocumentListProvider);
    final searchQuery = ref.watch(documentSearchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        title: _isSearching
            ? Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: _onSearchChanged,
                  decoration: const InputDecoration(
                    hintText: 'Search documents...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              )
            : const Text('PocketVault'),
        leading: _isSearching
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _toggleSearch,
              )
            : null,
        actions: _isSearching
            ? [
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    ref.read(documentSearchQueryProvider.notifier).state = '';
                  },
                ),
              ]
            : [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _toggleSearch,
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _showFilterBottomSheet,
                ),
              ],
      ),
      body: documentsAsyncValue.when(
        // The data is available, build the list
        data: (documents) {
          if (documents.isEmpty) {
            if (searchQuery.isNotEmpty) {
              // Empty search results
              return EmptyStateWidget(
                title: 'No documents found',
                subtitle: 'Try adjusting your search terms or filters',
                icon: Icons.search_off,
                action: ElevatedButton.icon(
                  onPressed: () {
                    _searchController.clear();
                    ref.read(documentSearchQueryProvider.notifier).state = '';
                    ref.read(documentFilterStateProvider.notifier).state = 
                        const DocumentFilter();
                  },
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear Search'),
                ),
              );
            } else {
              // No documents at all
              return EmptyStateWidget(
                title: 'No documents yet',
                subtitle: 'Tap the + button to add your first document!',
                icon: Icons.description_outlined,
                action: ElevatedButton.icon(
                  onPressed: () => context.go('/add-document'),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Document'),
                ),
              );
            }
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: 8), // Small top padding
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final doc = documents[index];
                    return DocumentListItem(document: doc);
                  },
                  childCount: documents.length,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 80), // Bottom padding for FAB
              ),
            ],
          );
        },
        // The data is still loading, show a spinner
        loading: () => const Center(child: CircularProgressIndicator()),
        // An error occurred, show an error message
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                err.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AddDocumentSourceSheet(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
