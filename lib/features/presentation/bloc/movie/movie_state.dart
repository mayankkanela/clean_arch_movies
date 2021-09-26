part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class ErrorState extends MovieState {
  final String message;

  const ErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  const MovieLoaded({required this.movies});
  @override
  List<Object?> get props => [movies];
}
