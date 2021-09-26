import 'package:movies/features/domain/entities/movie.dart';

class MovieModel extends Movie {
  static const titleConst = 'title';
  static const directorConst = 'directorConst';
  static const imagePathConst = 'imagePath';

  const MovieModel({
    required String title,
    required String director,
    required String imagePath,
  }) : super(title: title, director: director, imagePath: imagePath);

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        title: json[titleConst],
        director: json[directorConst],
        imagePath: json[imagePathConst],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        titleConst: title,
        directorConst: director,
        imagePathConst: imagePathConst
      };
}
