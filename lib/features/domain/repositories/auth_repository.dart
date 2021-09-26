import 'package:dartz/dartz.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/features/domain/entities/current_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, CurrentUser>> signIn();

  Future<Either<Failure, bool>> logOut();
  Future<Either<Failure, CurrentUser>> checkUser();
}
