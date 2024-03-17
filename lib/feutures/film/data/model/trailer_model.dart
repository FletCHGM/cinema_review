class TrailerModel {
  final String url;
  final String name;
  final String site;
  final String type;
  factory TrailerModel.fromJSON(Map<String, dynamic> json) => TrailerModel(
        url: json['url'],
        name: json['name'],
        site: json['site'],
        type: json['type'],
      );

  TrailerModel({
    required this.url,
    required this.name,
    required this.site,
    required this.type,
  });
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'site': site,
      'type': type,
    };
  }
}


//         "url": "https://www.youtube.com/embed/Xtf3c-Y20Lw",
//         "name": "Ведьмак (1 сезон) — Русский трейлер (Озвучка, 2019)",
//         "site": "youtube",
//         "type": "TRAILER"
//