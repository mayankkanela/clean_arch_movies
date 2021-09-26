import 'package:dartz/dartz.dart';
import 'package:movies/core/error/exceptions.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/features/data/datasources/auth_remote_data_source.dart';
import 'package:movies/features/domain/entities/current_user.dart';
import 'package:movies/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      await _authRemoteDataSource.logOut();
      return const Right(true);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CurrentUser>> signIn() async {
    try {
      final data = await _authRemoteDataSource.signIn();
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CurrentUser>> checkUser() async {
    try {
      return Right(await _authRemoteDataSource.checkUser());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
