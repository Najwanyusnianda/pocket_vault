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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
