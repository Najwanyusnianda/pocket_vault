import '../../../../core/database/models/document_type.dart';

enum DocumentSortBy {
  dateDesc,
  dateAsc,
  nameAsc,
  nameDesc,
}

class DocumentFilter {
  final DocumentSortBy sortBy;
  final bool showFavoritesOnly;
  final bool showArchivedOnly;
  final MainType? mainTypeFilter;

  const DocumentFilter({
    this.sortBy = DocumentSortBy.dateDesc,
    this.showFavoritesOnly = false,
    this.showArchivedOnly = false,
    this.mainTypeFilter,
  });

  DocumentFilter copyWith({
    DocumentSortBy? sortBy,
    bool? showFavoritesOnly,
    bool? showArchivedOnly,
    MainType? mainTypeFilter,
  }) {
    return DocumentFilter(
      sortBy: sortBy ?? this.sortBy,
      showFavoritesOnly: showFavoritesOnly ?? this.showFavoritesOnly,
      showArchivedOnly: showArchivedOnly ?? this.showArchivedOnly,
      mainTypeFilter: mainTypeFilter ?? this.mainTypeFilter,
    );
  }
}
