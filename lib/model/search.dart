class Search {
  final String title;

  Search({this.title});

  factory Search.fromJson(Map<String, dynamic> json) {
    return new Search(
      title: json['title'],
    );
  }
}

var returnData = Search();
