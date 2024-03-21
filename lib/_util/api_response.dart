// ignore_for_file: public_member_api_docs, sort_constructors_first

// Package imports:
import 'package:dartz/dartz.dart';

typedef APIResponse<T> = Either<Failure, T>;

class Failure {
  final dynamic code;
  final Object response;

  Failure({
    this.code = 500,
    required this.response,
  });

  @override
  String toString() => 'Failure(code: $code, response: $response)';
}
