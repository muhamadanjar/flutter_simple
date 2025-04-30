// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeSliderState {
  List<SliderItem> get sliders => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of HomeSliderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeSliderStateCopyWith<HomeSliderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeSliderStateCopyWith<$Res> {
  factory $HomeSliderStateCopyWith(
    HomeSliderState value,
    $Res Function(HomeSliderState) then,
  ) = _$HomeSliderStateCopyWithImpl<$Res, HomeSliderState>;
  @useResult
  $Res call({List<SliderItem> sliders, int currentIndex, String? errorMessage});
}

/// @nodoc
class _$HomeSliderStateCopyWithImpl<$Res, $Val extends HomeSliderState>
    implements $HomeSliderStateCopyWith<$Res> {
  _$HomeSliderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeSliderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sliders = null,
    Object? currentIndex = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            sliders:
                null == sliders
                    ? _value.sliders
                    : sliders // ignore: cast_nullable_to_non_nullable
                        as List<SliderItem>,
            currentIndex:
                null == currentIndex
                    ? _value.currentIndex
                    : currentIndex // ignore: cast_nullable_to_non_nullable
                        as int,
            errorMessage:
                freezed == errorMessage
                    ? _value.errorMessage
                    : errorMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeSliderStateImplCopyWith<$Res>
    implements $HomeSliderStateCopyWith<$Res> {
  factory _$$HomeSliderStateImplCopyWith(
    _$HomeSliderStateImpl value,
    $Res Function(_$HomeSliderStateImpl) then,
  ) = __$$HomeSliderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SliderItem> sliders, int currentIndex, String? errorMessage});
}

/// @nodoc
class __$$HomeSliderStateImplCopyWithImpl<$Res>
    extends _$HomeSliderStateCopyWithImpl<$Res, _$HomeSliderStateImpl>
    implements _$$HomeSliderStateImplCopyWith<$Res> {
  __$$HomeSliderStateImplCopyWithImpl(
    _$HomeSliderStateImpl _value,
    $Res Function(_$HomeSliderStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeSliderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sliders = null,
    Object? currentIndex = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$HomeSliderStateImpl(
        sliders:
            null == sliders
                ? _value._sliders
                : sliders // ignore: cast_nullable_to_non_nullable
                    as List<SliderItem>,
        currentIndex:
            null == currentIndex
                ? _value.currentIndex
                : currentIndex // ignore: cast_nullable_to_non_nullable
                    as int,
        errorMessage:
            freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$HomeSliderStateImpl implements _HomeSliderState {
  const _$HomeSliderStateImpl({
    required final List<SliderItem> sliders,
    this.currentIndex = 0,
    this.errorMessage,
  }) : _sliders = sliders;

  final List<SliderItem> _sliders;
  @override
  List<SliderItem> get sliders {
    if (_sliders is EqualUnmodifiableListView) return _sliders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sliders);
  }

  @override
  @JsonKey()
  final int currentIndex;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'HomeSliderState(sliders: $sliders, currentIndex: $currentIndex, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeSliderStateImpl &&
            const DeepCollectionEquality().equals(other._sliders, _sliders) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_sliders),
    currentIndex,
    errorMessage,
  );

  /// Create a copy of HomeSliderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeSliderStateImplCopyWith<_$HomeSliderStateImpl> get copyWith =>
      __$$HomeSliderStateImplCopyWithImpl<_$HomeSliderStateImpl>(
        this,
        _$identity,
      );
}

abstract class _HomeSliderState implements HomeSliderState {
  const factory _HomeSliderState({
    required final List<SliderItem> sliders,
    final int currentIndex,
    final String? errorMessage,
  }) = _$HomeSliderStateImpl;

  @override
  List<SliderItem> get sliders;
  @override
  int get currentIndex;
  @override
  String? get errorMessage;

  /// Create a copy of HomeSliderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeSliderStateImplCopyWith<_$HomeSliderStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
