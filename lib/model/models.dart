class Movies {
  final String title;
  final String link;

  String error;

  Movies({
    this.title,
    this.link,
  });

  factory Movies.fromJson(dynamic json) {
    if (json == null) {
      return Movies();
    }

    return Movies(
      title: json['title'],
      link: json['link'],
    );
  }
}
