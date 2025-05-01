// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookingRemoteDataSourceHash() =>
    r'e08a54a127ba1edfd6b762b9c8186918352571a8';

/// See also [bookingRemoteDataSource].
@ProviderFor(bookingRemoteDataSource)
final bookingRemoteDataSourceProvider =
    AutoDisposeProvider<BookingRemoteDataSource>.internal(
      bookingRemoteDataSource,
      name: r'bookingRemoteDataSourceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$bookingRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookingRemoteDataSourceRef =
    AutoDisposeProviderRef<BookingRemoteDataSource>;
String _$bookingLocalDataSourceHash() =>
    r'9739a18f5133617d9ca795cd67bfb6f98ac91afb';

/// See also [bookingLocalDataSource].
@ProviderFor(bookingLocalDataSource)
final bookingLocalDataSourceProvider =
    AutoDisposeProvider<BookingLocalDataSource>.internal(
      bookingLocalDataSource,
      name: r'bookingLocalDataSourceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$bookingLocalDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookingLocalDataSourceRef =
    AutoDisposeProviderRef<BookingLocalDataSource>;
String _$bookingRepositoryHash() => r'a65fe6cb90f7fd185a70f979113bb69b0e9d80a6';

/// See also [bookingRepository].
@ProviderFor(bookingRepository)
final bookingRepositoryProvider =
    AutoDisposeProvider<BookingRepository>.internal(
      bookingRepository,
      name: r'bookingRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$bookingRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookingRepositoryRef = AutoDisposeProviderRef<BookingRepository>;
String _$availableTimesHash() => r'd008f7a762e62665fea84d32255a518f63fca4f9';

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

/// See also [availableTimes].
@ProviderFor(availableTimes)
const availableTimesProvider = AvailableTimesFamily();

/// See also [availableTimes].
class AvailableTimesFamily extends Family<AsyncValue<List<AvailableTime>>> {
  /// See also [availableTimes].
  const AvailableTimesFamily();

  /// See also [availableTimes].
  AvailableTimesProvider call(DateTime date) {
    return AvailableTimesProvider(date);
  }

  @override
  AvailableTimesProvider getProviderOverride(
    covariant AvailableTimesProvider provider,
  ) {
    return call(provider.date);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'availableTimesProvider';
}

/// See also [availableTimes].
class AvailableTimesProvider
    extends AutoDisposeFutureProvider<List<AvailableTime>> {
  /// See also [availableTimes].
  AvailableTimesProvider(DateTime date)
    : this._internal(
        (ref) => availableTimes(ref as AvailableTimesRef, date),
        from: availableTimesProvider,
        name: r'availableTimesProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$availableTimesHash,
        dependencies: AvailableTimesFamily._dependencies,
        allTransitiveDependencies:
            AvailableTimesFamily._allTransitiveDependencies,
        date: date,
      );

  AvailableTimesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    FutureOr<List<AvailableTime>> Function(AvailableTimesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AvailableTimesProvider._internal(
        (ref) => create(ref as AvailableTimesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AvailableTime>> createElement() {
    return _AvailableTimesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AvailableTimesProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AvailableTimesRef on AutoDisposeFutureProviderRef<List<AvailableTime>> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _AvailableTimesProviderElement
    extends AutoDisposeFutureProviderElement<List<AvailableTime>>
    with AvailableTimesRef {
  _AvailableTimesProviderElement(super.provider);

  @override
  DateTime get date => (origin as AvailableTimesProvider).date;
}

String _$bookingUseCaseHash() => r'9396f5bb096dc92f88837331d32bad650cff988d';

/// See also [bookingUseCase].
@ProviderFor(bookingUseCase)
final bookingUseCaseProvider = AutoDisposeProvider<BookingUseCase>.internal(
  bookingUseCase,
  name: r'bookingUseCaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bookingUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookingUseCaseRef = AutoDisposeProviderRef<BookingUseCase>;
String _$bookingNotifierHash() => r'1bb8246ccf38210a9e2ece752c764b44702cf659';

/// See also [BookingNotifier].
@ProviderFor(BookingNotifier)
final bookingNotifierProvider =
    AutoDisposeNotifierProvider<BookingNotifier, BookingState>.internal(
      BookingNotifier.new,
      name: r'bookingNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$bookingNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BookingNotifier = AutoDisposeNotifier<BookingState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
