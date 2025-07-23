// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'8c69eb46d45206533c176c88a926608e79ca927d';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = Provider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDatabaseRef = ProviderRef<AppDatabase>;
String _$documentsDaoHash() => r'ed437880ad21ab03e60a1ea2f8a745e7e9225792';

/// See also [documentsDao].
@ProviderFor(documentsDao)
final documentsDaoProvider = Provider<DocumentsDao>.internal(
  documentsDao,
  name: r'documentsDaoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$documentsDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DocumentsDaoRef = ProviderRef<DocumentsDao>;
String _$documentRepositoryHash() =>
    r'2b74be97e8839292066da13613815c7111685ba1';

/// See also [documentRepository].
@ProviderFor(documentRepository)
final documentRepositoryProvider =
    AutoDisposeProvider<DocumentRepository>.internal(
      documentRepository,
      name: r'documentRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$documentRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DocumentRepositoryRef = AutoDisposeProviderRef<DocumentRepository>;
String _$filteredDocumentListHash() =>
    r'382a29442b7cfb2bdd02dc3482e210c3c622d2b9';

/// See also [filteredDocumentList].
@ProviderFor(filteredDocumentList)
final filteredDocumentListProvider =
    AutoDisposeStreamProvider<List<Document>>.internal(
      filteredDocumentList,
      name: r'filteredDocumentListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredDocumentListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredDocumentListRef = AutoDisposeStreamProviderRef<List<Document>>;
String _$documentListStreamHash() =>
    r'd951188b6b41f1c339dbc1fb2897a355d15ebfe8';

/// See also [documentListStream].
@ProviderFor(documentListStream)
final documentListStreamProvider =
    AutoDisposeStreamProvider<List<Document>>.internal(
      documentListStream,
      name: r'documentListStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$documentListStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DocumentListStreamRef = AutoDisposeStreamProviderRef<List<Document>>;
String _$singleDocumentHash() => r'eac8adadb24864086303a25bf15232c4782cb469';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [singleDocument].
@ProviderFor(singleDocument)
const singleDocumentProvider = SingleDocumentFamily();

/// See also [singleDocument].
class SingleDocumentFamily extends Family<AsyncValue<Document>> {
  /// See also [singleDocument].
  const SingleDocumentFamily();

  /// See also [singleDocument].
  SingleDocumentProvider call(int documentId) {
    return SingleDocumentProvider(documentId);
  }

  @override
  SingleDocumentProvider getProviderOverride(
    covariant SingleDocumentProvider provider,
  ) {
    return call(provider.documentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'singleDocumentProvider';
}

/// See also [singleDocument].
class SingleDocumentProvider extends AutoDisposeStreamProvider<Document> {
  /// See also [singleDocument].
  SingleDocumentProvider(int documentId)
    : this._internal(
        (ref) => singleDocument(ref as SingleDocumentRef, documentId),
        from: singleDocumentProvider,
        name: r'singleDocumentProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$singleDocumentHash,
        dependencies: SingleDocumentFamily._dependencies,
        allTransitiveDependencies:
            SingleDocumentFamily._allTransitiveDependencies,
        documentId: documentId,
      );

  SingleDocumentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.documentId,
  }) : super.internal();

  final int documentId;

  @override
  Override overrideWith(
    Stream<Document> Function(SingleDocumentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SingleDocumentProvider._internal(
        (ref) => create(ref as SingleDocumentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        documentId: documentId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Document> createElement() {
    return _SingleDocumentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SingleDocumentProvider && other.documentId == documentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, documentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SingleDocumentRef on AutoDisposeStreamProviderRef<Document> {
  /// The parameter `documentId` of this provider.
  int get documentId;
}

class _SingleDocumentProviderElement
    extends AutoDisposeStreamProviderElement<Document>
    with SingleDocumentRef {
  _SingleDocumentProviderElement(super.provider);

  @override
  int get documentId => (origin as SingleDocumentProvider).documentId;
}

String _$documentFormHash() => r'b1eb623243c9f9fe6a0cb7eaf5e94dc62071c1e9';

/// See also [DocumentForm].
@ProviderFor(DocumentForm)
final documentFormProvider =
    AutoDisposeAsyncNotifierProvider<DocumentForm, void>.internal(
      DocumentForm.new,
      name: r'documentFormProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$documentFormHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DocumentForm = AutoDisposeAsyncNotifier<void>;
String _$documentUpdateHash() => r'cc9c789ac8d98c3008e38355f78bdeb9fa0061b0';

/// See also [DocumentUpdate].
@ProviderFor(DocumentUpdate)
final documentUpdateProvider =
    AutoDisposeAsyncNotifierProvider<DocumentUpdate, void>.internal(
      DocumentUpdate.new,
      name: r'documentUpdateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$documentUpdateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DocumentUpdate = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
