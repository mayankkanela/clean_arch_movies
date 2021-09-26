import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/extensions/string.dart';
import 'package:movies/features/domain/entities/movie.dart';
import 'package:movies/features/presentation/bloc/movie/movie_bloc.dart';

class HomeBottomSheet extends StatefulWidget {
  const HomeBottomSheet({Key? key, this.movie, this.index}) : super(key: key);
  final Movie? movie;

  final int? index;

  @override
  State<HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;
  late final TextEditingController _directorController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _directorController = TextEditingController();
    if (widget.movie != null) {
      _titleController.text = widget.movie!.title;
      _directorController.text = widget.movie!.director;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _directorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.movie == null ? widget.index == null : widget.index != null);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              validator: (t) => t.nullOrEmptyValidator(),
              decoration: const InputDecoration(
                focusColor: Colors.yellow,
                label: Text('Title'),
              ),
            ),
            TextFormField(
              controller: _directorController,
              validator: (t) => t.nullOrEmptyValidator(),
              decoration: const InputDecoration(
                focusColor: Colors.yellow,
                label: Text(
                  'Director',
                ),
              ),
            ),
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<MovieBloc>(context).add(widget.movie == null
                      ? AddMovieEvent(
                          movie: Movie(
                              title: _titleController.text,
                              director: _directorController.text,
                              imagePath: 'na'))
                      : EditMovieEvent(
                          index: widget.index!,
                          movie: Movie(
                              title: _titleController.text,
                              director: _directorController.text,
                              imagePath: 'na')));
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
