import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/core/colors/custom_colors.dart';
import 'package:movies/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:movies/features/presentation/bloc/movie/movie_bloc.dart';
import 'package:movies/features/presentation/pages/home/home_page.dart';
import 'package:movies/features/presentation/pages/sign_in_page.dart';
import 'package:movies/features/presentation/pages/splash.dart';
import 'package:movies/injection_container.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await di.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<MovieBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movies',
        theme: ThemeData(
          primaryColor: Colors.black,
          textTheme: const TextTheme(
              headline1: TextStyle(
                color: CustomColors.darkBlue,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
              headline2: TextStyle(
                color: CustomColors.darkBlue,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              subtitle2: TextStyle(
                  color: Colors.yellow,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
              subtitle1: TextStyle(
                  color: Colors.yellow,
                  fontSize: 24,
                  fontWeight: FontWeight.w700)),
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                BlocProvider.of<AuthBloc>(context).add(CheckUserEvent());
              });
              return const Splash();
            } else if (state is SignedOut) {
              return const SignInPage();
            } else if (state is SignedIn) {
              return const HomePage();
            } else {
              return const SignInPage();
            }
          },
        ),
      ),
    );
  }
}
