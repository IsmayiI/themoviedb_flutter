import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/assets/images.dart';
import 'package:themoviedb_flutter/widgets/theme/app_colors.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: 10,
      itemExtent: 163,
      itemBuilder: (BuildContext context, int index) {
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
                      Image(image: AppImages.rosemaryImg),
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
                                    'Rosemary\'s Baby',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'June 12, 1968',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color:
                                            Color.fromRGBO(153, 153, 153, 1)),
                                  ),
                                ],
                              ),
                              Text(
                                'A young couple, Rosemary and Guy, moves into an infamous New York apartment building, known by frightening legends and mysterious events, with the purpose of starting a family.',
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
                    onTap: () {
                      print('ok');
                    },
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
