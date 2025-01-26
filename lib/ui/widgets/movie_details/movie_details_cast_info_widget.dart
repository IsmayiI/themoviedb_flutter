import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/provider/provider.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb_flutter/ui/widgets/theme/app_colors.dart';
import 'package:themoviedb_flutter/utils/image_url.dart';

class MovieDetailsCastInfoWidget extends StatelessWidget {
  const MovieDetailsCastInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final castList = NotifierProvider.watch<MovieDetailsModel>(context)
        .movieDetails
        ?.credits
        .cast;

    if (castList == null) return const SizedBox.shrink();

    final cast = castList.length > 9 ? castList.sublist(0, 9) : castList;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TitleWidget(),
          SizedBox(
            height: 246,
            child: Scrollbar(
              child: ListView.builder(
                  itemCount: cast.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return _CastItemWidget(index);
                  }),
            ),
          ),
          SizedBox(height: 20),
          const _SecondTitleWidget(),
        ],
      ),
    );
  }
}

class _CastItemWidget extends StatelessWidget {
  const _CastItemWidget(this.index);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
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
          child: _PersonWidget(index),
        ),
        if (index != 8) SizedBox(width: 10),
      ],
    );
  }
}

class _PersonWidget extends StatelessWidget {
  final int index;
  const _PersonWidget(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ProfileImgWidget(index),
        Padding(
          padding: const EdgeInsets.all(10),
          child: _NameWidget(index),
        ),
      ],
    );
  }
}

class _NameWidget extends StatelessWidget {
  final int index;
  const _NameWidget(this.index);

  @override
  Widget build(BuildContext context) {
    final castList = NotifierProvider.watch<MovieDetailsModel>(context)
        .movieDetails
        ?.credits
        .cast;

    if (castList == null) return const SizedBox.shrink();

    final cast = castList.length > 9 ? castList.sublist(0, 9) : castList;

    final person = cast[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          person.name,
          maxLines: 2,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Text(
          person.character,
          maxLines: 2,
        ),
      ],
    );
  }
}

class _ProfileImgWidget extends StatelessWidget {
  final int index;
  const _ProfileImgWidget(this.index);

  @override
  Widget build(BuildContext context) {
    final castList = NotifierProvider.watch<MovieDetailsModel>(context)
        .movieDetails
        ?.credits
        .cast;

    if (castList == null) return const SizedBox.shrink();

    final cast = castList.length > 9 ? castList.sublist(0, 9) : castList;

    final profilePath = cast[index].profilePath;

    if (profilePath == null) {
      return Container(
        width: 120,
        height: 133,
        color: AppColors.lightGrey,
        child: Icon(
          Icons.person,
          size: 120,
          color: Color(0xFFB5B5B5),
        ),
      );
    }

    return Image.network(
      imageUrl(profilePath),
      width: 120,
      height: 133,
      fit: BoxFit.cover,
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    return const Text('Top Billed Cast',
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600));
  }
}

class _SecondTitleWidget extends StatelessWidget {
  const _SecondTitleWidget();

  @override
  Widget build(BuildContext context) {
    return const TextButton(
      onPressed: null,
      child: Text(
        'Full Cast & Crew',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
