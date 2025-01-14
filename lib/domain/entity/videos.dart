import 'package:json_annotation/json_annotation.dart';

part 'videos.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Videos {
  Videos({
    required this.videos,
  });
  @JsonKey(name: 'results')
  final List<Video> videos;

  factory Videos.fromJson(Map<String, dynamic> json) => _$VideosFromJson(json);

  Map<String, dynamic> toJson() => _$VideosToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Video {
  Video({
    required this.iso,
    required this.isoTwo,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });
  @JsonKey(name: 'iso_639_1')
  final String iso;
  @JsonKey(name: 'iso_3166_1')
  final String isoTwo;
  final String name;
  final String key;
  final String site;
  final int? size;
  final String? type;
  final bool? official;
  final String? publishedAt;
  final String id;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
