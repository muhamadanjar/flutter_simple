// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$trainingRemoteDataSourceHash() =>
    r'8456d9bb32719a3f1ace08b62fd106d9ad1d7acf';

/// See also [trainingRemoteDataSource].
@ProviderFor(trainingRemoteDataSource)
final trainingRemoteDataSourceProvider =
    AutoDisposeProvider<TrainingDataSource>.internal(
      trainingRemoteDataSource,
      name: r'trainingRemoteDataSourceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$trainingRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TrainingRemoteDataSourceRef =
    AutoDisposeProviderRef<TrainingDataSource>;
String _$trainingRepositoryHash() =>
    r'0b28fea0c645eb5813924dc8d280ad6b3beb514b';

/// See also [trainingRepository].
@ProviderFor(trainingRepository)
final trainingRepositoryProvider =
    AutoDisposeProvider<TrainingRepository>.internal(
      trainingRepository,
      name: r'trainingRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$trainingRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TrainingRepositoryRef = AutoDisposeProviderRef<TrainingRepository>;
String _$trainingNotifierHash() => r'232a11ac1acfcc09f7fe352e893a102de2fe5885';

/// See also [TrainingNotifier].
@ProviderFor(TrainingNotifier)
final trainingNotifierProvider =
    AutoDisposeNotifierProvider<TrainingNotifier, TrainingState>.internal(
      TrainingNotifier.new,
      name: r'trainingNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$trainingNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TrainingNotifier = AutoDisposeNotifier<TrainingState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
