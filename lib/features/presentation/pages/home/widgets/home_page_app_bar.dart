import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/colors/custom_colors.dart';
import 'package:movies/features/presentation/bloc/auth/auth_bloc.dart';

class HomePageAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomePageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        'Movies',
        style: Theme.of(context).textTheme.headline2,
      ),
      actions: [
        IconButton(
            icon: const Icon(
              Icons.logout,
              color: CustomColors.darkBlue,
            ),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
            })
      ],
      elevation: 2,
      shadowColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
