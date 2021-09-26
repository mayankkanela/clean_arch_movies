import 'package:dartz/dartz.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/core/usecase/usecase.dart';
import 'package:movies/features/domain/entities/movie.dart';
import 'package:movies/features/domain/repositories/movie_repository.dart';

class GetAllMovies implements UseCase<List<Movie>, NoParams> {
  final MovieRepository _movieRepository;

  GetAllMovies({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) async =>
      await _movieRepository.getAllMovies();
}
