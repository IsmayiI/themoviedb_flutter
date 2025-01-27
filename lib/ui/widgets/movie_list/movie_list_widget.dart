import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb_flutter/ui/widgets/theme/app_colors.dart';
import 'package:themoviedb_flutter/utils/image_url.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<MovieListModel>().setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieListModel>();

    if (model.errorMessage != null) {
      return Center(
          child: Text(
        model.errorMessage as String,
        style: const TextStyle(color: Colors.red),
      ));
    }

    final listContent = model.isListLoading
        ? const Center(
            child: CircularProgressIndicator(color: AppColors.darkBlue))
        : const _MovieListWidget();

    return Stack(
      children: [
        listContent,
        const _SearchWidget(),
      ],
    );
  }
}

class _MovieListWidget extends StatelessWidget {
  const _MovieListWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieListModel>();

    if (model.movies.isEmpty) {
      return const Center(child: Text('No movies were found for your request'));
    }

    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.only(top: 96, bottom: 20, left: 20, right: 20),
      itemCount: model.movies.length,
      itemExtent: 163,
      itemBuilder: (BuildContext context, int index) {
        final movie = model.movies[index];
        model.onScrollEnd(index);

        final releaseDate = movie.releaseDate == null
            ? ''
            : model.stringFromDate(movie.releaseDate!);

        final posterImg = movie.posterPath == null
            ? const SizedBox.shrink()
            : Image.network(
                imageUrl(movie.posterPath!),
                width: 94,
                height: 143,
                fit: BoxFit.cover,
              );

        return Column(
          children: [
            Expanded(
              child: Stack(children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.lightGrey),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, .1),
                        offset: Offset(0, 2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      posterImg,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    releaseDate,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color:
                                            Color.fromRGBO(153, 153, 153, 1)),
                                  ),
                                ],
                              ),
                              Text(
                                movie.overview,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: () => model.onTapMovie(context, index),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieListModel>();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        onChanged: (text) => model.searchMovie(text),
        decoration: InputDecoration(
          labelText: 'Search',
          filled: true,
          fillColor: Colors.white.withAlpha(200),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
