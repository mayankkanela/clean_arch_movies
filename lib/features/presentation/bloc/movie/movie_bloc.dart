import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movies/core/usecase/usecase.dart';
import 'package:movies/features/data/models/movie_model.dart';
import 'package:movies/features/domain/entities/movie.dart';
import 'package:movies/features/domain/usecases/movieusecases/add_movie.dart';
import 'package:movies/features/domain/usecases/movieusecases/delete_movie.dart';
import 'package:movies/features/domain/usecases/movieusecases/edit_movie.dart';
import 'package:movies/features/domain/usecases/movieusecases/get_all_movies.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final AddMovie _addMovie;
  final GetAllMovies _getAllMovies;
  final EditMovie _editMovie;
  final DeleteMovie _deleteMovie;

  MovieBloc({
    required AddMovie addMovie,
    required GetAllMovies getAllMovies,
    required EditMovie editMovie,
    required DeleteMovie deleteMovie,
  })  : _addMovie = addMovie,
        _getAllMovies = getAllMovies,
        _editMovie = editMovie,
        _deleteMovie = deleteMovie,
        super(MovieInitial()) {
    on<MovieEvent>((event, emit) async {
      if (event is GetMoviesEvent) {
        final dataOrError = await _getAllMovies(NoParams());
        emit(dataOrError.fold(
            (l) => const ErrorState(message: 'Something went wrong.'),
            (r) => MovieLoaded(movies: r)));
      } else if (event is AddMovieEvent) {
        final getMovieOrError = await _getAllMovies(NoParams());
        List<Movie>? list;
        getMovieOrError.fold((l) => () {}, (List<Movie> r) => list = r);
        if (list != null) {
          list!.add(MovieModel(
              title: event.movie.title,
              director: event.movie.title,
              imagePath: event.movie.title));
          final dataOrError = await _addMovie(AddMovieParams(movies: list!));
          emit(dataOrError.fold(
              (l) => const ErrorState(message: 'Something went wrong.'),
              (r) => MovieLoaded(movies: r)));
        } else {
          emit(const ErrorState(message: 'Something went wrong.'));
        }
      } else if (event is EditMovieEvent) {
        final getMovieOrError = await _getAllMovies(NoParams());
        List<Movie>? list;
        getMovieOrError.fold((l) => () {}, (List<Movie> r) => list = r);
        if (list != null) {
          list![event.index] = MovieModel(
              title: event.movie.title,
              director: event.movie.title,
              imagePath: event.movie.title);
          final dataOrError = await _editMovie(EditMovieParams(movies: list!));
          emit(dataOrError.fold(
              (l) => const ErrorState(message: 'Something went wrong.'),
              (r) => MovieLoaded(movies: r)));
        } else {
          emit(const ErrorState(message: 'Something went wrong.'));
        }
      } else if (event is DeleteMovieEvent) {
        final getMovieOrError = await _getAllMovies(NoParams());
        List<Movie>? list;
        getMovieOrError.fold((l) => () {}, (List<Movie> r) => list = r);
        if (list != null) {
          list!.removeAt(event.index);
          final dataOrError =
              await _deleteMovie(DeleteMovieParam(movies: list!));
          emit(dataOrError.fold(
              (l) => const ErrorState(message: 'Something went wrong.'),
              (r) => MovieLoaded(movies: r)));
        } else {
          emit(const ErrorState(message: 'Something went wrong.'));
        }
      }
    });
  }
}
