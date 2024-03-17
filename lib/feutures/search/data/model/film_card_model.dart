class FilmCardModel {
  final int id;
  final String name;
  final String posterUrl;
  final double? rating;
  final String? shortDescription;
  factory FilmCardModel.fromJSON(Map<String, dynamic> json) => FilmCardModel(
      id: json['id'],
      name: json['name'],
      posterUrl: json['poster']['previewUrl'] ?? '',
      rating: json['rating']['kp'] + 0.0,
      shortDescription: json['shortDescription']);

  FilmCardModel(
      {required this.id,
      required this.name,
      required this.posterUrl,
      required this.rating,
      required this.shortDescription});
}

// {
//       "id": 466581,
//       "name": "Хранители снов",
//       "alternativeName": "Rise of the Guardians",
//       "enName": "",
//       "type": "cartoon",
//       "year": 2012,
//       "description": "Когда злой дух Кромешник посягает на самое дорогое – детские мечты, Северянин, Ледяной Джек, Кролик, Зубная Фея и Песочный Человек впервые объединяются, чтобы создать команду Хранителей снов...",
//       "shortDescription": "Злодей сеет страх в мире детских грез — команда Санты спешит на помощь. Мультфильм с истинным духом Рождества",
//       "movieLength": 97,
//       "isSeries": false,
//       "ticketsOnSale": false,
//       "totalSeriesLength": null,
//       "seriesLength": null,
//       "ratingMpaa": "pg",
//       "ageRating": 0,
//       "top10": null,
//       "top250": 98,
//       "typeNumber": 3,
//       "status": null,
//       "names": [
//         {
//           "name": "Хранители снов"
//         },
//         {
//           "name": "Rise of the Guardians"
//         },
//         {
//           "name": "De Eventyrlige Vogtere",
//           "language": "DK",
//           "type": null
//         },
//         {
//           "name": "捍衛聯盟",
//           "language": "TW",
//           "type": null
//         },
//         {
//           "name": "Les Cinq Légendes",
//           "language": "FR",
//           "type": null
//         },
//         {
//           "name": "守护者",
//           "language": "CN",
//           "type": null
//         },
//         {
//           "name": "守护者的崛起",
//           "language": "CN",
//           "type": null
//         },
//         {
//           "name": "五星大聯盟",
//           "language": "HK",
//           "type": null
//         },
//         {
//           "name": "Die Glorreichen Fünf",
//           "language": "DE",
//           "type": null
//         },
//         {
//           "name": "Rise of The Guardians 3D",
//           "language": "US",
//           "type": "3D version"
//         },
//         {
//           "name": "Viis legendi",
//           "language": "EE",
//           "type": null
//         },
//         {
//           "name": "Les Réveil Des Gardiens",
//           "language": "FR",
//           "type": null
//         },
//         {
//           "name": "El Origen de los Guardianes",
//           "language": "ES",
//           "type": null
//         },
//         {
//           "name": "Le 5 leggende",
//           "language": "IT",
//           "type": null
//         }
//       ],
//       "externalId": {
//         "imdb": "tt1446192",
//         "tmdb": 81188,
//         "kpHD": "45165df7a0e401eaaafb3f6c90d8198e"
//       },
//       "logo": {
//         "url": "https://avatars.mds.yandex.net/get-ott/2439731/2a00000171a63d9680acc96acde8ae00912e/orig"
//       },
//       "poster": {
//         "url": "https://image.openmoviedb.com/kinopoisk-images/1599028/c6d5650b-1c39-4946-86f8-460220ee1949/orig",
//         "previewUrl": "https://image.openmoviedb.com/kinopoisk-images/1599028/c6d5650b-1c39-4946-86f8-460220ee1949/x1000"
//       },
//       "backdrop": {
//         "url": "https://image.openmoviedb.com/tmdb-images/original/46IGtYNjpIvQYRIQlb2X493Wh8x.jpg",
//         "previewUrl": "https://image.openmoviedb.com/tmdb-images/w500/46IGtYNjpIvQYRIQlb2X493Wh8x.jpg"
//       },
//       "rating": {
//         "kp": 7.958,
//         "imdb": 7.2,
//         "filmCritics": 6.6,
//         "russianFilmCritics": 100,
//         "await": null
//       },
//       "votes": {
//         "kp": 300744,
//         "imdb": 191534,
//         "filmCritics": 161,
//         "russianFilmCritics": 5,
//         "await": 14213
//       },
//       "genres": [
//         {
//           "name": "мультфильм"
//         },
//         {
//           "name": "фэнтези"
//         },
//         {
//           "name": "боевик"
//         },
//         {
//           "name": "драма"
//         },
//         {
//           "name": "комедия"
//         },
//         {
//           "name": "приключения"
//         },
//         {
//           "name": "семейный"
//         }
//       ],
//       "countries": [
//         {
//           "name": "США"
//         },
//         {
//           "name": "Индия"
//         }
//       ],
//       "releaseYears": []
//     }
//   ],
//   "total": 1000,
//   "limit": 10,
//   "page": 1,
//   "pages": 100
  