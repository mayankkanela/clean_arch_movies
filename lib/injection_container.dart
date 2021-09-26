import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:movies/features/data/datasources/auth_remote_data_source.dart';
import 'package:movies/features/data/datasources/movie_local_data_source.dart';
import 'package:movies/features/data/repositories/auth_repository_impl.dart';
import 'package:movies/features/data/repositories/movie_repository_impl.dart';
import 'package:movies/features/domain/repositories/auth_repository.dart';
import 'package:movies/features/domain/repositories/movie_repository.dart';
import 'package:movies/features/domain/usecases/authusecases/check_user.dart';
import 'package:movies/features/domain/usecases/authusecases/log_out.dart';
import 'package:movies/features/domain/usecases/authusecases/sign_in.dart';
import 'package:movies/features/domain/usecases/movieusecases/add_movie.dart';
import 'package:movies/features/domain/usecases/movieusecases/delete_movie.dart';
import 'package:movies/features/domain/usecases/movieusecases/edit_movie.dart';
import 'package:movies/features/domain/usecases/movieusecases/get_all_movies.dart';
import 'package:movies/features/presentation/bloc/movie/movie_bloc.dart';

import 'features/presentation/bloc/auth/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - GithubRepo
  // Bloc

  sl.registerFactory(
    () => AuthBloc(
      signIn: sl(),
      logOut: sl(),
      checkUser: sl(),
    ),
  );
  sl.registerLazySingleton(() => MovieBloc(
        addMovie: sl(),
        getAllMovies: sl(),
        editMovie: sl(),
        deleteMovie: sl(),
      ));
  // Use Case
  sl.registerLazySingleton(() => SignIn(authRepository: sl()));
  sl.registerLazySingleton(() => LogOut(authRepository: sl()));
  sl.registerLazySingleton(() => CheckUser(authRepository: sl()));
  sl.registerLazySingleton(() => GetAllMovies(movieRepository: sl()));
  sl.registerLazySingleton(() => EditMovie(movieRepository: sl()));
  sl.registerLazySingleton(() => AddMovie(movieRepository: sl()));
  sl.registerLazySingleton(() => DeleteMovie(movieRepository: sl()));
  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl()));
  sl.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(movieLocalDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(firebaseAuth: FirebaseAuth.instance));

  sl.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(box: sl()));

  // Core

  // External
  final Box box = await Hive.openBox('data');
  sl.registerLazySingleton(() => box);
}
