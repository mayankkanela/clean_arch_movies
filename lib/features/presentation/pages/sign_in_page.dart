import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/core/colors/custom_colors.dart';
import 'package:movies/features/presentation/bloc/auth/auth_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Welcome, sign in to continue.',
              style: Theme.of(context).textTheme.headline1,
            ),
            IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(SignInEvent());
              },
              icon: const FaIcon(
                FontAwesomeIcons.google,
                size: 48,
                color: CustomColors.darkBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
