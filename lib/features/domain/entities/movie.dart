import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String director;
  final String imagePath;

  const Movie({
    required this.title,
    required this.director,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [title, director, imagePath];
}
