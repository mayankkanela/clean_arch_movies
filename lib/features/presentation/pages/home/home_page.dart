import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/colors/custom_colors.dart';
import 'package:movies/features/domain/entities/movie.dart';
import 'package:movies/features/presentation/bloc/movie/movie_bloc.dart';
import 'package:movies/features/presentation/pages/home/widgets/home_bottom_sheet.dart';
import 'package:movies/features/presentation/pages/home/widgets/home_page_app_bar.dart';
import 'package:movies/features/presentation/pages/home/widgets/list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: const HomePageAppBar(),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoaded) {
              return ListView.builder(
                  itemCount: state.movies.length,
                  itemBuilder: (_, i) {
                    final movie = state.movies[i];
                    return ListItem(
                      movie: movie,
                      index: i,
                    );
                  });
            }
            if (state is ErrorState) {
              return Center(
                child: Text(
                  'Some error occurred',
                  style: Theme.of(context).textTheme.headline2,
                ),
              );
            } else {
              WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                BlocProvider.of<MovieBloc>(context).add(GetMoviesEvent());
              });
              return Center(
                child: Text(
                  'Loading',
                  style: Theme.of(context).textTheme.headline2,
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors.darkBlue,
          child: const Icon(Icons.add),
          onPressed: () => _showBottomSheet(context),
        ),
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
          return const HomeBottomSheet();
        });
  }
}
