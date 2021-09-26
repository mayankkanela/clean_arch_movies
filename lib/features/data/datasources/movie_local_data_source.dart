import 'dart:convert';
import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:movies/core/error/exceptions.dart';
import 'package:movies/features/data/models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>> getAllMovies();
  Future<bool> addMovie({required List<MovieModel> movieModels});
  Future<bool> deleteMovie({required List<MovieModel> movieModels});
  Future<bool> editMovie({required List<MovieModel> movieModels});
}

class MovieLocalDataSourceImpl extends MovieLocalDataSource {
  final Box _box;

  MovieLocalDataSourceImpl({required Box box}) : _box = box;
  @override
  Future<bool> addMovie({required List<MovieModel> movieModels}) async {
    try {
      log('here');
      final String json =
          jsonEncode(movieModels.map((e) => e.toJson()).toList());
      await _box.put('movies', json);
      return true;
    } catch (e) {
      log(e.toString());

      throw CacheException();
    }
  }

  @override
  Future<bool> deleteMovie({required List<MovieModel> movieModels}) async {
    try {
      final String json =
          jsonEncode(movieModels.map((e) => e.toJson()).toList());
      await _box.put('movies', json);
      return true;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> editMovie({required List<MovieModel> movieModels}) async {
    try {
      final String json =
          jsonEncode(movieModels.map((e) => e.toJson()).toList());
      await _box.put('movies', json);
      return true;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<MovieModel>> getAllMovies() async {
    try {
      if (!_box.containsKey('movies')) {
        _box.put('movies', '[]');
      }
      final json = await _box.get('movies');
      log(json);
      final data = jsonDecode(json) as List;
      return data.map((e) => MovieModel.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }
}
