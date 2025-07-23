// lib/features/documents/presentation/widgets/document_list/filter_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/database/models/document_type.dart';
import '../../../data/models/document_filter.dart';
import '../../providers/document_providers.dart';

class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  ConsumerState<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  late DocumentFilter _localFilter;

  @override
  void initState() {
    super.initState();
    _localFilter = ref.read(documentFilterStateProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                'Sort & Filter',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    _localFilter = const DocumentFilter();
                  });
                },
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Sort Controls
          Text(
            'Sort by',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SegmentedButton<DocumentSortBy>(
            segments: const [
              ButtonSegment(
                value: DocumentSortBy.dateDesc,
                label: Text('Newest'),
                icon: Icon(Icons.arrow_downward),
              ),
              ButtonSegment(
                value: DocumentSortBy.dateAsc,
                label: Text('Oldest'),
                icon: Icon(Icons.arrow_upward),
              ),
              ButtonSegment(
                value: DocumentSortBy.nameAsc,
                label: Text('A-Z'),
                icon: Icon(Icons.sort_by_alpha),
              ),
            ],
            selected: {_localFilter.sortBy},
            onSelectionChanged: (Set<DocumentSortBy> selection) {
              setState(() {
                _localFilter = _localFilter.copyWith(sortBy: selection.first);
              });
            },
          ),
          const SizedBox(height: 24),

          // Filter Controls
          Text(
            'Filter by',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          CheckboxListTile(
            title: const Text('Favorites only'),
            value: _localFilter.showFavoritesOnly,
            onChanged: (value) {
              setState(() {
                _localFilter = _localFilter.copyWith(showFavoritesOnly: value ?? false);
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Archived only'),
            value: _localFilter.showArchivedOnly,
            onChanged: (value) {
              setState(() {
                _localFilter = _localFilter.copyWith(showArchivedOnly: value ?? false);
              });
            },
          ),

          // Document Type Filter
          const SizedBox(height: 16),
          Text(
            'Document Type',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<MainType?>(
            decoration: const InputDecoration(
              labelText: 'Filter by type',
              border: OutlineInputBorder(),
            ),
            value: _localFilter.mainTypeFilter,
            items: [
              const DropdownMenuItem<MainType?>(
                value: null,
                child: Text('All types'),
              ),
              ...MainType.values.map((type) => DropdownMenuItem<MainType?>(
                value: type,
                child: Text(_getMainTypeName(type)),
              )),
            ],
            onChanged: (value) {
              setState(() {
                _localFilter = _localFilter.copyWith(mainTypeFilter: value);
              });
            },
          ),
          const SizedBox(height: 24),

          // Apply Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ref.read(documentFilterStateProvider.notifier).state = _localFilter;
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _getMainTypeName(MainType mainType) {
    switch (mainType) {
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
        return 'Other';
    }
  }
}
