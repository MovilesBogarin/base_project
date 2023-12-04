// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reportHash() => r'bcc52dfab5a3c6bbde66cbe8b5ecf4dfb29aeaa7';

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

abstract class _$Report
    extends BuildlessAutoDisposeAsyncNotifier<List<Ingredient>> {
  late final String dateInit;
  late final String dateEnd;

  FutureOr<List<Ingredient>> build(
    String dateInit,
    String dateEnd,
  );
}

/// See also [Report].
@ProviderFor(Report)
const reportProvider = ReportFamily();

/// See also [Report].
class ReportFamily extends Family<AsyncValue<List<Ingredient>>> {
  /// See also [Report].
  const ReportFamily();

  /// See also [Report].
  ReportProvider call(
    String dateInit,
    String dateEnd,
  ) {
    return ReportProvider(
      dateInit,
      dateEnd,
    );
  }

  @override
  ReportProvider getProviderOverride(
    covariant ReportProvider provider,
  ) {
    return call(
      provider.dateInit,
      provider.dateEnd,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'reportProvider';
}

/// See also [Report].
class ReportProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Report, List<Ingredient>> {
  /// See also [Report].
  ReportProvider(
    String dateInit,
    String dateEnd,
  ) : this._internal(
          () => Report()
            ..dateInit = dateInit
            ..dateEnd = dateEnd,
          from: reportProvider,
          name: r'reportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reportHash,
          dependencies: ReportFamily._dependencies,
          allTransitiveDependencies: ReportFamily._allTransitiveDependencies,
          dateInit: dateInit,
          dateEnd: dateEnd,
        );

  ReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dateInit,
    required this.dateEnd,
  }) : super.internal();

  final String dateInit;
  final String dateEnd;

  @override
  FutureOr<List<Ingredient>> runNotifierBuild(
    covariant Report notifier,
  ) {
    return notifier.build(
      dateInit,
      dateEnd,
    );
  }

  @override
  Override overrideWith(Report Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReportProvider._internal(
        () => create()
          ..dateInit = dateInit
          ..dateEnd = dateEnd,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dateInit: dateInit,
        dateEnd: dateEnd,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Report, List<Ingredient>>
      createElement() {
    return _ReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportProvider &&
        other.dateInit == dateInit &&
        other.dateEnd == dateEnd;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dateInit.hashCode);
    hash = _SystemHash.combine(hash, dateEnd.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReportRef on AutoDisposeAsyncNotifierProviderRef<List<Ingredient>> {
  /// The parameter `dateInit` of this provider.
  String get dateInit;

  /// The parameter `dateEnd` of this provider.
  String get dateEnd;
}

class _ReportProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Report, List<Ingredient>>
    with ReportRef {
  _ReportProviderElement(super.provider);

  @override
  String get dateInit => (origin as ReportProvider).dateInit;
  @override
  String get dateEnd => (origin as ReportProvider).dateEnd;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
