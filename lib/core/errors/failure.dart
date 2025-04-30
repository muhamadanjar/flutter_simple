import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({required String message, int? code})
      : super(message: message, code: code);
}

class CacheFailure extends Failure {
  const CacheFailure({required String message, int? code})
      : super(message: message, code: code);
}

class AuthFailure extends Failure {
  const AuthFailure({required String message, int? code})
      : super(message: message, code: code);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({ required super.message, super.code});
}