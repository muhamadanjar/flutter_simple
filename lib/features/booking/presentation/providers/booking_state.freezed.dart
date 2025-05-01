// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BookingState {
  String get bookingDetails => throw _privateConstructorUsedError;
  DateTime get bookingDate => throw _privateConstructorUsedError;
  String get bookingTime => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingStateCopyWith<BookingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingStateCopyWith<$Res> {
  factory $BookingStateCopyWith(
    BookingState value,
    $Res Function(BookingState) then,
  ) = _$BookingStateCopyWithImpl<$Res, BookingState>;
  @useResult
  $Res call({
    String bookingDetails,
    DateTime bookingDate,
    String bookingTime,
    bool isLoading,
    String? errorMessage,
  });
}

/// @nodoc
class _$BookingStateCopyWithImpl<$Res, $Val extends BookingState>
    implements $BookingStateCopyWith<$Res> {
  _$BookingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingDetails = null,
    Object? bookingDate = null,
    Object? bookingTime = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            bookingDetails:
                null == bookingDetails
                    ? _value.bookingDetails
                    : bookingDetails // ignore: cast_nullable_to_non_nullable
                        as String,
            bookingDate:
                null == bookingDate
                    ? _value.bookingDate
                    : bookingDate // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            bookingTime:
                null == bookingTime
                    ? _value.bookingTime
                    : bookingTime // ignore: cast_nullable_to_non_nullable
                        as String,
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
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
abstract class _$$BookingStateImplCopyWith<$Res>
    implements $BookingStateCopyWith<$Res> {
  factory _$$BookingStateImplCopyWith(
    _$BookingStateImpl value,
    $Res Function(_$BookingStateImpl) then,
  ) = __$$BookingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String bookingDetails,
    DateTime bookingDate,
    String bookingTime,
    bool isLoading,
    String? errorMessage,
  });
}

/// @nodoc
class __$$BookingStateImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingStateImpl>
    implements _$$BookingStateImplCopyWith<$Res> {
  __$$BookingStateImplCopyWithImpl(
    _$BookingStateImpl _value,
    $Res Function(_$BookingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingDetails = null,
    Object? bookingDate = null,
    Object? bookingTime = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$BookingStateImpl(
        bookingDetails:
            null == bookingDetails
                ? _value.bookingDetails
                : bookingDetails // ignore: cast_nullable_to_non_nullable
                    as String,
        bookingDate:
            null == bookingDate
                ? _value.bookingDate
                : bookingDate // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        bookingTime:
            null == bookingTime
                ? _value.bookingTime
                : bookingTime // ignore: cast_nullable_to_non_nullable
                    as String,
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
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

class _$BookingStateImpl extends _BookingState {
  const _$BookingStateImpl({
    required this.bookingDetails,
    required this.bookingDate,
    required this.bookingTime,
    this.isLoading = false,
    this.errorMessage,
  }) : super._();

  @override
  final String bookingDetails;
  @override
  final DateTime bookingDate;
  @override
  final String bookingTime;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'BookingState(bookingDetails: $bookingDetails, bookingDate: $bookingDate, bookingTime: $bookingTime, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingStateImpl &&
            (identical(other.bookingDetails, bookingDetails) ||
                other.bookingDetails == bookingDetails) &&
            (identical(other.bookingDate, bookingDate) ||
                other.bookingDate == bookingDate) &&
            (identical(other.bookingTime, bookingTime) ||
                other.bookingTime == bookingTime) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    bookingDetails,
    bookingDate,
    bookingTime,
    isLoading,
    errorMessage,
  );

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingStateImplCopyWith<_$BookingStateImpl> get copyWith =>
      __$$BookingStateImplCopyWithImpl<_$BookingStateImpl>(this, _$identity);
}

abstract class _BookingState extends BookingState {
  const factory _BookingState({
    required final String bookingDetails,
    required final DateTime bookingDate,
    required final String bookingTime,
    final bool isLoading,
    final String? errorMessage,
  }) = _$BookingStateImpl;
  const _BookingState._() : super._();

  @override
  String get bookingDetails;
  @override
  DateTime get bookingDate;
  @override
  String get bookingTime;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingStateImplCopyWith<_$BookingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
