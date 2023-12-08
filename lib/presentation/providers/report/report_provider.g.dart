// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reportHash() => r'28c605c109598c6958037a46a6dec8fa017f056b';

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
    extends BuildlessAutoDisposeAsyncNotifier<List<CheckedList>> {
  late final String dateInit;
  late final String dateFinal;

  FutureOr<List<CheckedList>> build(
    String dateInit,
    String dateFinal,
  );
}

/// See also [Report].
@ProviderFor(Report)
const reportProvider = ReportFamily();

/// See also [Report].
class ReportFamily extends Family<AsyncValue<List<CheckedList>>> {
  /// See also [Report].
  const ReportFamily();

  /// See also [Report].
  ReportProvider call(
    String dateInit,
    String dateFinal,
  ) {
    return ReportProvider(
      dateInit,
      dateFinal,
    );
  }

  @override
  ReportProvider getProviderOverride(
    covariant ReportProvider provider,
  ) {
    return call(
      provider.dateInit,
      provider.dateFinal,
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
    extends AutoDisposeAsyncNotifierProviderImpl<Report, List<CheckedList>> {
  /// See also [Report].
  ReportProvider(
    String dateInit,
    String dateFinal,
  ) : this._internal(
          () => Report()
            ..dateInit = dateInit
            ..dateFinal = dateFinal,
          from: reportProvider,
          name: r'reportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reportHash,
          dependencies: ReportFamily._dependencies,
          allTransitiveDependencies: ReportFamily._allTransitiveDependencies,
          dateInit: dateInit,
          dateFinal: dateFinal,
        );

  ReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dateInit,
    required this.dateFinal,
  }) : super.internal();

  final String dateInit;
  final String dateFinal;

  @override
  FutureOr<List<CheckedList>> runNotifierBuild(
    covariant Report notifier,
  ) {
    return notifier.build(
      dateInit,
      dateFinal,
    );
  }

  @override
  Override overrideWith(Report Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReportProvider._internal(
        () => create()
          ..dateInit = dateInit
          ..dateFinal = dateFinal,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dateInit: dateInit,
        dateFinal: dateFinal,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Report, List<CheckedList>>
      createElement() {
    return _ReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportProvider &&
        other.dateInit == dateInit &&
        other.dateFinal == dateFinal;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dateInit.hashCode);
    hash = _SystemHash.combine(hash, dateFinal.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReportRef on AutoDisposeAsyncNotifierProviderRef<List<CheckedList>> {
  /// The parameter `dateInit` of this provider.
  String get dateInit;

  /// The parameter `dateFinal` of this provider.
  String get dateFinal;
}

class _ReportProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Report, List<CheckedList>>
    with ReportRef {
  _ReportProviderElement(super.provider);

  @override
  String get dateInit => (origin as ReportProvider).dateInit;
  @override
  String get dateFinal => (origin as ReportProvider).dateFinal;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
