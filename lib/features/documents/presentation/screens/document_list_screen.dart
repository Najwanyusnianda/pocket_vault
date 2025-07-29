import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Import the provider you created in the data layer step
import '../providers/document_providers.dart';
import '../controllers/add_document_controller.dart';
import '../controllers/document_list_controller.dart';
import '../widgets/document_list/document_list_item.dart';
import '../widgets/document_list/filter_bottom_sheet.dart';
import '../widgets/add_document/add_document_source_sheet.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../core/services/file_picker_service.dart';

class DocumentListScreen extends ConsumerStatefulWidget {
  const DocumentListScreen({super.key});

  @override
  ConsumerState<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends ConsumerState<DocumentListScreen> {
  bool _isSearching = false;
  bool _isLoadingDialogShowing = false; // ✅ Track dialog state explicitly
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // ✅ Helper method to show loading dialog
  void _showLoadingDialog() {
    if (!_isLoadingDialogShowing && mounted) {
      _isLoadingDialogShowing = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  // ✅ Helper method to dismiss loading dialog
  void _dismissLoadingDialog() {
    if (_isLoadingDialogShowing && mounted) {
      _isLoadingDialogShowing = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
    });

    if (_isSearching) {
      _searchFocusNode.requestFocus();
    } else {
      _searchController.clear();
      ref.read(documentListControllerProvider.notifier).clearSearch();
      _searchFocusNode.unfocus();
    }
  }

  void _onSearchChanged(String query) {
    ref.read(documentListControllerProvider.notifier).updateSearchQuery(query);
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
    // 🔍 FIXED: Better dialog management for add document controller
    ref.listen<AsyncValue<FilePickerResult?>>(addDocumentControllerProvider, (previous, next) {
      debugPrint('👂 [Listener] State changed: $next');
      
      // Handle loading state
      if (next is AsyncLoading) {
        debugPrint('⏳ [Listener] Loading state - showing dialog');
        _showLoadingDialog();
      } 
      // Handle success state with file selected
      else if (next is AsyncData && next.value != null) {
        debugPrint('🚀 [Listener] Navigating to /add-document with file: ${next.value?.fileName}');
        _dismissLoadingDialog();
        context.go('/add-document', extra: next.value);
      }
      // ✅ FIXED: Handle user cancellation (AsyncData with null value)
      else if (next is AsyncData && next.value == null) {
        debugPrint('ℹ️ [Listener] User cancelled file selection - dismissing dialog with NEW method');
        _dismissLoadingDialog();
        // No error message needed for cancellation
      } 
      // Handle error state
      else if (next is AsyncError) {
        debugPrint('❌ [Listener] Error received: ${next.error}');
        _dismissLoadingDialog();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${next.error}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });

    // Use the new DocumentListController instead of direct providers
    final documentListState = ref.watch(documentListControllerProvider);
    
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
                    ref.read(documentListControllerProvider.notifier).clearSearch();
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
      body: _buildBody(documentListState),
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

  Widget _buildBody(DocumentListState state) {
    // Watch the filtered documents separately from the controller state
    final documentsAsyncValue = ref.watch(filteredDocumentListProvider);
    
    return documentsAsyncValue.when(
      data: (documents) {
        if (documents.isEmpty) {
          if (state.searchQuery.isNotEmpty) {
            // Empty search results
            return EmptyStateWidget(
              title: 'No documents found',
              subtitle: 'Try adjusting your search terms or filters',
              icon: Icons.search_off,
              action: ElevatedButton.icon(
                onPressed: () {
                  _searchController.clear();
                  ref.read(documentListControllerProvider.notifier).clearSearch();
                  ref.read(documentListControllerProvider.notifier).clearFilters();
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
            const SliverToBoxAdapter(
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
            const SliverToBoxAdapter(
              child: SizedBox(height: 80), // Bottom padding for FAB
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
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
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => ref.refresh(filteredDocumentListProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
