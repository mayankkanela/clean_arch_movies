import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/core/usecase/usecase.dart';
import 'package:movies/features/domain/entities/movie.dart';
import 'package:movies/features/domain/repositories/movie_repository.dart';

class DeleteMovie implements UseCase<List<Movie>, DeleteMovieParam> {
  final MovieRepository _movieRepository;

  DeleteMovie({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Either<Failure, List<Movie>>> call(DeleteMovieParam params) async =>
      await _movieRepository.deleteMovie(movies: params.movies);
}

class DeleteMovieParam extends Equatable {
  final List<Movie> movies;

  const DeleteMovieParam({required this.movies});

  @override
  List<Object?> get props => [movies];
}
