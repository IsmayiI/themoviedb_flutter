import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/assets/images.dart';
import 'package:themoviedb_flutter/widgets/theme/app_colors.dart';

class Movie {
  final int id;
  final String title;
  final String description;
  final AssetImage image;
  final String date;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
  });
}

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(
      id: 1,
      title: 'Rosemary\'s Baby',
      description:
          'A young couple, Rosemary and Guy, moves into an infamous New York apartment building, known by frightening legends and mysterious events, with the purpose of starting a family.',
      image: AppImages.rosemaryImg,
      date: 'June 12, 1968',
    ),
    Movie(
      id: 2,
      title: 'Red One',
      description:
          'A young couple, Rosemary and Guy, moves into an infamous New York apartment building, known by frightening legends and mysterious events, with the purpose of starting a family.',
      image: AppImages.rosemaryImg,
      date: 'June 12, 1968',
    ),
    Movie(
      id: 3,
      title: 'taxi',
      description:
          'A young couple, Rosemary and Guy, moves into an infamous New York apartment building, known by frightening legends and mysterious events, with the purpose of starting a family.',
      image: AppImages.rosemaryImg,
      date: 'June 12, 1968',
    ),
    Movie(
      id: 4,
      title: 'batman',
      description:
          'A young couple, Rosemary and Guy, moves into an infamous New York apartment building, known by frightening legends and mysterious events, with the purpose of starting a family.',
      image: AppImages.rosemaryImg,
      date: 'June 12, 1968',
    ),
    Movie(
      id: 5,
      title: 'it',
      description:
          'A young couple, Rosemary and Guy, moves into an infamous New York apartment building, known by frightening legends and mysterious events, with the purpose of starting a family.',
      image: AppImages.rosemaryImg,
      date: 'June 12, 1968',
    ),
    Movie(
      id: 6,
      title: 'it follows',
      description:
          'A young couple, Rosemary and Guy, moves into an infamous New York apartment building, known by frightening legends and mysterious events, with the purpose of starting a family.',
      image: AppImages.rosemaryImg,
      date: 'June 12, 1968',
    ),
    Movie(
      id: 7,
      title: 'the hills have eyes',
      description:
          'A young couple, Rosemary and Guy, moves into an infamous New York apartment building, known by frightening legends and mysterious events, with the purpose of starting a family.',
      image: AppImages.rosemaryImg,
      date: 'June 12, 1968',
    ),
    Movie(
      id: 1,
      title: 'avengers',
      description:
          'A young couple, Rosemary and Guy, moves into an infamous New York apartment building, known by frightening legends and mysterious events, with the purpose of starting a family.',
      image: AppImages.rosemaryImg,
      date: 'June 12, 1968',
    ),
    Movie(
      id: 8,
      title: 'spiderman',
      description:
          'A young couple, Rosemary and Guy, moves into an infamous New York apartment building, known by frightening legends and mysterious events, with the purpose of starting a family.',
      image: AppImages.rosemaryImg,
      date: 'June 12, 1968',
    ),
    Movie(
      id: 9,
      title: 'the house of 1000 doors',
      description:
          'A young couple, Rosemary and Guy, moves into an infamous New York apartment building, known by frightening legends and mysterious events, with the purpose of starting a family.',
      image: AppImages.rosemaryImg,
      date: 'June 12, 1968',
    ),
    Movie(
      id: 10,
      title: 'the order',
      description:
          'A young couple, Rosemary and Guy, moves into an infamous New York apartment building, known by frightening legends and mysterious events, with the purpose of starting a family.',
      image: AppImages.rosemaryImg,
      date: 'June 12, 1968',
    ),
  ];

  var _filteredMovies = <Movie>[];

  final _searchController = TextEditingController();

  void _searchMovies() {
    final query = _searchController.text.toLowerCase().trim();

    if (query.isNotEmpty) {
      _filteredMovies = _movies
          .where((movie) => movie.title.toLowerCase().contains(query))
          .toList();
    } else {
      _filteredMovies = _movies;
    }
    setState(() {});
  }

  void _onTapMovie(int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed('/main/movie_details', arguments: id);
  }

  @override
  void initState() {
    super.initState();

    _filteredMovies = _movies;
    _searchController.addListener(_searchMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding:
              const EdgeInsets.only(top: 96, bottom: 20, left: 20, right: 20),
          itemCount: _filteredMovies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final movie = _filteredMovies[index];

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
                          Image(image: movie.image),
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
                                        movie.date,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1)),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    movie.description,
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
                        onTap: () => _onTapMovie(index),
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
            controller: _searchController,
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
