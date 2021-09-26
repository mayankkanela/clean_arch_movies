import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/core/usecase/usecase.dart';
import 'package:movies/features/domain/entities/movie.dart';
import 'package:movies/features/domain/repositories/movie_repository.dart';

class EditMovie implements UseCase<List<Movie>, EditMovieParams> {
  final MovieRepository _movieRepository;

  EditMovie({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Either<Failure, List<Movie>>> call(EditMovieParams params) async =>
      await _movieRepository.editMovie(
        movies: params.movies,
      );
}

class EditMovieParams extends Equatable {
  final List<Movie> movies;

  const EditMovieParams({
    required this.movies,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
