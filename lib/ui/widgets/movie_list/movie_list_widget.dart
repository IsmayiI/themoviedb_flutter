import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/domain/api_client/api_service.dart';
import 'package:themoviedb_flutter/provider/provider.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb_flutter/ui/widgets/theme/app_colors.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieListModel>(context);

    return Stack(
      children: [
        ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding:
              const EdgeInsets.only(top: 96, bottom: 20, left: 20, right: 20),
          itemCount: model.movies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final movie = model.movies[index];

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
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, .1),
                            offset: Offset(0, 2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            ApiService.imageUrl(movie.posterPath),
                            width: 94,
                            height: 143,
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 24),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        model.stringFromDate(movie.releaseDate),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1)),
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
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              filled: true,
              fillColor: Colors.white.withAlpha(200),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
