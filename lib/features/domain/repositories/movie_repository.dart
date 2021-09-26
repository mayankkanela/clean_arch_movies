import 'package:dartz/dartz.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/features/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getAllMovies();

  Future<Either<Failure, List<Movie>>> deleteMovie(
      {required List<Movie> movies});

  Future<Either<Failure, List<Movie>>> editMovie({required List<Movie> movies});

  Future<Either<Failure, List<Movie>>> addMovie({required List<Movie> movies});
}
