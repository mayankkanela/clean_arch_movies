import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movies/core/error/exceptions.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/features/data/datasources/movie_local_data_source.dart';
import 'package:movies/features/data/models/movie_model.dart';
import 'package:movies/features/domain/entities/movie.dart';
import 'package:movies/features/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieLocalDataSource _movieLocalDataSource;

  MovieRepositoryImpl({required MovieLocalDataSource movieLocalDataSource})
      : _movieLocalDataSource = movieLocalDataSource;

  @override
  Future<Either<Failure, List<Movie>>> addMovie(
      {required List<Movie> movies}) async {
    try {
      final res = await _movieLocalDataSource.addMovie(
          movieModels: movies
              .map((e) => MovieModel(
                  title: e.title, director: e.director, imagePath: e.imagePath))
              .toList());

      return Right(movies);
    } on CacheException {
      log('message');
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> deleteMovie(
      {required List<Movie> movies}) async {
    try {
      final res = await _movieLocalDataSource.deleteMovie(
          movieModels: movies
              .map((e) => MovieModel(
                  title: e.title, director: e.director, imagePath: e.imagePath))
              .toList());
      return Right(movies);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> editMovie(
      {required List<Movie> movies}) async {
    try {
      final res = await _movieLocalDataSource.editMovie(
          movieModels: movies
              .map((e) => MovieModel(
                  title: e.title, director: e.director, imagePath: e.imagePath))
              .toList());
      return Right(movies);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getAllMovies() async {
    try {
      final res = await _movieLocalDataSource.getAllMovies();
      return Right(res);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
