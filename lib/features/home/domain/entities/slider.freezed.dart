// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SliderItem {
  int get id => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Create a copy of SliderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SliderItemCopyWith<SliderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SliderItemCopyWith<$Res> {
  factory $SliderItemCopyWith(
    SliderItem value,
    $Res Function(SliderItem) then,
  ) = _$SliderItemCopyWithImpl<$Res, SliderItem>;
  @useResult
  $Res call({int id, String imageUrl, String title, String description});
}

/// @nodoc
class _$SliderItemCopyWithImpl<$Res, $Val extends SliderItem>
    implements $SliderItemCopyWith<$Res> {
  _$SliderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SliderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            imageUrl:
                null == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SliderItemImplCopyWith<$Res>
    implements $SliderItemCopyWith<$Res> {
  factory _$$SliderItemImplCopyWith(
    _$SliderItemImpl value,
    $Res Function(_$SliderItemImpl) then,
  ) = __$$SliderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String imageUrl, String title, String description});
}

/// @nodoc
class __$$SliderItemImplCopyWithImpl<$Res>
    extends _$SliderItemCopyWithImpl<$Res, _$SliderItemImpl>
    implements _$$SliderItemImplCopyWith<$Res> {
  __$$SliderItemImplCopyWithImpl(
    _$SliderItemImpl _value,
    $Res Function(_$SliderItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SliderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(
      _$SliderItemImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        imageUrl:
            null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$SliderItemImpl implements _SliderItem {
  const _$SliderItemImpl({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  final int id;
  @override
  final String imageUrl;
  @override
  final String title;
  @override
  final String description;

  @override
  String toString() {
    return 'SliderItem(id: $id, imageUrl: $imageUrl, title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SliderItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, imageUrl, title, description);

  /// Create a copy of SliderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SliderItemImplCopyWith<_$SliderItemImpl> get copyWith =>
      __$$SliderItemImplCopyWithImpl<_$SliderItemImpl>(this, _$identity);
}

abstract class _SliderItem implements SliderItem {
  const factory _SliderItem({
    required final int id,
    required final String imageUrl,
    required final String title,
    required final String description,
  }) = _$SliderItemImpl;

  @override
  int get id;
  @override
  String get imageUrl;
  @override
  String get title;
  @override
  String get description;

  /// Create a copy of SliderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SliderItemImplCopyWith<_$SliderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
