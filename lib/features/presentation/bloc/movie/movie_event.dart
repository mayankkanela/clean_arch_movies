part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {}

class GetMoviesEvent extends MovieEvent {}

class AddMovieEvent extends MovieEvent {
  final Movie movie;

  AddMovieEvent({required this.movie});
}

class EditMovieEvent extends MovieEvent {
  final Movie movie;
  final int index;

  EditMovieEvent({required this.index, required this.movie});
}

class DeleteMovieEvent extends MovieEvent {
  final int index;

  DeleteMovieEvent({required this.index});
}
