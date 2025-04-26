// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authStateHash() => r'70b60d089a00ab32938bdef75ff31c70c4c3bfa8';

/// See also [authState].
@ProviderFor(authState)
final authStateProvider = AutoDisposeStreamProvider<AuthResult>.internal(
  authState,
  name: r'authStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateRef = AutoDisposeStreamProviderRef<AuthResult>;
String _$hasRoleHash() => r'e433090c81abbfe9202989ed4e0b2d8a6c551341';

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

/// See also [hasRole].
@ProviderFor(hasRole)
const hasRoleProvider = HasRoleFamily();

/// See also [hasRole].
class HasRoleFamily extends Family<AsyncValue<bool>> {
  /// See also [hasRole].
  const HasRoleFamily();

  /// See also [hasRole].
  HasRoleProvider call(String userId, String role) {
    return HasRoleProvider(userId, role);
  }

  @override
  HasRoleProvider getProviderOverride(covariant HasRoleProvider provider) {
    return call(provider.userId, provider.role);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hasRoleProvider';
}

/// See also [hasRole].
class HasRoleProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [hasRole].
  HasRoleProvider(String userId, String role)
    : this._internal(
        (ref) => hasRole(ref as HasRoleRef, userId, role),
        from: hasRoleProvider,
        name: r'hasRoleProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$hasRoleHash,
        dependencies: HasRoleFamily._dependencies,
        allTransitiveDependencies: HasRoleFamily._allTransitiveDependencies,
        userId: userId,
        role: role,
      );

  HasRoleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.role,
  }) : super.internal();

  final String userId;
  final String role;

  @override
  Override overrideWith(FutureOr<bool> Function(HasRoleRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: HasRoleProvider._internal(
        (ref) => create(ref as HasRoleRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        role: role,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _HasRoleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HasRoleProvider &&
        other.userId == userId &&
        other.role == role;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, role.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HasRoleRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `role` of this provider.
  String get role;
}

class _HasRoleProviderElement extends AutoDisposeFutureProviderElement<bool>
    with HasRoleRef {
  _HasRoleProviderElement(super.provider);

  @override
  String get userId => (origin as HasRoleProvider).userId;
  @override
  String get role => (origin as HasRoleProvider).role;
}

String _$currentUserHash() => r'b1cce63c97d55128f56cce7239eeb203e1e690a3';

/// See also [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeFutureProvider<User?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = AutoDisposeFutureProviderRef<User?>;
String _$authNotifierHash() => r'62cf254861bad265dee276fffd70e7a46163f32e';

/// See also [AuthNotifier].
@ProviderFor(AuthNotifier)
final authNotifierProvider =
    AutoDisposeAsyncNotifierProvider<AuthNotifier, void>.internal(
      AuthNotifier.new,
      name: r'authNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$authNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AuthNotifier = AutoDisposeAsyncNotifier<void>;
String _$authorizationNotifierHash() =>
    r'e9e46d2a542f7563cdde75888e4870e7156184a2';

abstract class _$AuthorizationNotifier
    extends BuildlessAutoDisposeAsyncNotifier<bool> {
  late final String requiredRole;

  FutureOr<bool> build(String requiredRole);
}

/// See also [AuthorizationNotifier].
@ProviderFor(AuthorizationNotifier)
const authorizationNotifierProvider = AuthorizationNotifierFamily();

/// See also [AuthorizationNotifier].
class AuthorizationNotifierFamily extends Family<AsyncValue<bool>> {
  /// See also [AuthorizationNotifier].
  const AuthorizationNotifierFamily();

  /// See also [AuthorizationNotifier].
  AuthorizationNotifierProvider call(String requiredRole) {
    return AuthorizationNotifierProvider(requiredRole);
  }

  @override
  AuthorizationNotifierProvider getProviderOverride(
    covariant AuthorizationNotifierProvider provider,
  ) {
    return call(provider.requiredRole);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'authorizationNotifierProvider';
}

/// See also [AuthorizationNotifier].
class AuthorizationNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AuthorizationNotifier, bool> {
  /// See also [AuthorizationNotifier].
  AuthorizationNotifierProvider(String requiredRole)
    : this._internal(
        () => AuthorizationNotifier()..requiredRole = requiredRole,
        from: authorizationNotifierProvider,
        name: r'authorizationNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$authorizationNotifierHash,
        dependencies: AuthorizationNotifierFamily._dependencies,
        allTransitiveDependencies:
            AuthorizationNotifierFamily._allTransitiveDependencies,
        requiredRole: requiredRole,
      );

  AuthorizationNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.requiredRole,
  }) : super.internal();

  final String requiredRole;

  @override
  FutureOr<bool> runNotifierBuild(covariant AuthorizationNotifier notifier) {
    return notifier.build(requiredRole);
  }

  @override
  Override overrideWith(AuthorizationNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: AuthorizationNotifierProvider._internal(
        () => create()..requiredRole = requiredRole,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        requiredRole: requiredRole,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AuthorizationNotifier, bool>
  createElement() {
    return _AuthorizationNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthorizationNotifierProvider &&
        other.requiredRole == requiredRole;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, requiredRole.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AuthorizationNotifierRef on AutoDisposeAsyncNotifierProviderRef<bool> {
  /// The parameter `requiredRole` of this provider.
  String get requiredRole;
}

class _AuthorizationNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AuthorizationNotifier, bool>
    with AuthorizationNotifierRef {
  _AuthorizationNotifierProviderElement(super.provider);

  @override
  String get requiredRole =>
      (origin as AuthorizationNotifierProvider).requiredRole;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
