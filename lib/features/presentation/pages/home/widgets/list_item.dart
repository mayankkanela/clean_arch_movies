import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/colors/custom_colors.dart';
import 'package:movies/features/domain/entities/movie.dart';
import 'package:movies/features/presentation/bloc/movie/movie_bloc.dart';
import 'package:movies/features/presentation/pages/home/widgets/home_bottom_sheet.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.movie, required this.index})
      : super(key: key);

  final Movie movie;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: CustomColors.darkBlue, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.file(
                File(movie.imagePath),
                height: 64,
                width: 64,
                fit: BoxFit.cover,
                errorBuilder: (_, o, st) => Image.asset(
                  'assets/images/noImg.png',
                  height: 64,
                  width: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              Column(
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    movie.director,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<MovieBloc>(context)
                      .add(DeleteMovieEvent(index: index));
                },
                color: Colors.red,
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () =>
                    _showBottomSheet(context, movie: movie, index: index),
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, {Movie? movie, int? index}) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        context: context,
        backgroundColor: CustomColors.darkBlue,
        builder: (_) {
          return HomeBottomSheet(
            movie: movie,
            index: index,
          );
        });
  }
}
