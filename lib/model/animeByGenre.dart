class AnimeByGenre {
  AnimeByGenre({
    this.id,
    this.name,
    this.thumb,
    this.score,
  });

  String id;
  String name;
  String thumb;
  double score;

  factory AnimeByGenre.fromJson(Map<String, dynamic> json) => AnimeByGenre(
        id: json["id"],
        name: json["anime_name"],
        thumb: json["thumb"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "anime_name": name,
        "thumb": thumb,
        "score": score,
      };
}
