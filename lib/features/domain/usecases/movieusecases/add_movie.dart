import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/core/usecase/usecase.dart';
import 'package:movies/features/domain/entities/movie.dart';
import 'package:movies/features/domain/repositories/movie_repository.dart';

class AddMovie implements UseCase<List<Movie>, AddMovieParams> {
  final MovieRepository _movieRepository;

  AddMovie({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Either<Failure, List<Movie>>> call(AddMovieParams params) async =>
      await _movieRepository.addMovie(movies: params.movies);
}

class AddMovieParams extends Equatable {
  final List<Movie> movies;

  const AddMovieParams({required this.movies});

  @override
  List<Object?> get props => [movies];
}
