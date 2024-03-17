import 'package:cinema_review/feutures/film/data/model/actor_model.dart';
import 'package:cinema_review/feutures/film/data/model/trailer_model.dart';

class FilmReviewModel {
  final int id;
  final String name;
  final String description;
  final int votesCount;
  final double rating;
  final String ageRating;
  final List<String> genres;
  final String cash;
  final String premierDate;
  final List<ActorModel> actors;
  final List<TrailerModel> trailers;
  final String poster;

  FilmReviewModel({
    required this.id,
    required this.name,
    required this.description,
    required this.votesCount,
    required this.rating,
    required this.ageRating,
    required this.genres,
    required this.cash,
    required this.premierDate,
    required this.actors,
    required this.trailers,
    required this.poster,
  });

  factory FilmReviewModel.fromJSON(Map<String, dynamic> json) =>
      FilmReviewModel(
        id: json['id'],
        name: json['name'],
        description: json['description'] ?? '',
        votesCount: json['votes']['kp'] ?? 0,
        ageRating: json['ageRating'] != null ? '${json['ageRating']}+' : 'н.д.',
        genres: List.generate(
            json['genres'].length, (index) => json['genres'][index]['name']),
        cash: (json['fees']?['world']?['value'] ?? 0).toString() +
            (json['fees']?['world']?['currency'] ?? ''),
        premierDate: json['premiere']['world'] ?? '',
        actors: List.generate(
          json['persons'].length,
          (index) => ActorModel.fromJSON(
            json['persons']?[index],
          ),
        ),
        trailers: List.generate(
          json['videos']?['trailers'].length ?? 0,
          (index) => TrailerModel.fromJSON(
            json['videos']?['trailers']?[index],
          ),
        ),
        rating: json['rating']?['kp'] + 0.0 ?? 0.0,
        poster: json['backdrop']?['url'] ?? '',
      );
  factory FilmReviewModel.fromMap(Map<String, dynamic> json) => FilmReviewModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        votesCount: json['votesCount'],
        ageRating: json['ageRating'],
        genres: List.generate(
          json['genres'].length,
          (index) => json['genres'][index]['name'],
        ),
        cash: json['cash'],
        premierDate: json['premierDate'],
        actors: List.generate(
          json['actors'].length,
          (index) => ActorModel.fromJSON(
            json['actors']?[index],
          ),
        ),
        trailers: List.generate(
          json['trailers']?.length ?? 0,
          (index) => TrailerModel.fromJSON(
            json['trailers']?[index],
          ),
        ),
        rating: json['rating'] + 0.0,
        poster: json['poster'],
      );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'votesCount': votesCount,
      'rating': rating,
      'ageRating': ageRating,
      'cash': cash,
      'premierDate': premierDate,
      'poster': poster,
    };
  }
}

// название, 
// описание, 
// год выпуска, 
// количество голосов, 
// возрастной рейтинг, 
// жанр, 
// общие сборы в мире, 
// дата премьеры в мире, 
// список актёров с фото, 
// трейлер или тизер

// {
//   "status": null,
//   "externalId": {
//     "imdb": "tt5180504",
//     "tmdb": 71912
//   },
//   "rating": {
//     "kp": 7.167,
//     "imdb": 8,
//     "filmCritics": 0,
//     "russianFilmCritics": 68,
//     "await": null
//   },
//   "votes": {
//     "kp": 436768,
//     "imdb": 565751,
//     "filmCritics": 0,
//     "russianFilmCritics": 25,
//     "await": 20050
//   },
//   "backdrop": {
//     "url": "https://image.openmoviedb.com/tmdb-images/original/foGkPxpw9h8zln81j63mix5B7m8.jpg",
//     "previewUrl": "https://image.openmoviedb.com/tmdb-images/w500/foGkPxpw9h8zln81j63mix5B7m8.jpg"
//   },
//   "images": {
//     "postersCount": 37,
//     "backdropsCount": 33,
//     "framesCount": 87
//   },
//   "productionCompanies": [
//     {
//       "name": "Sean Daniel Company",
//       "url": null,
//       "previewUrl": null
//     },
//     {
//       "name": "Platige Image",
//       "url": null,
//       "previewUrl": null
//     },
//     {
//       "name": "Pioneer Stilking Films",
//       "url": null,
//       "previewUrl": null
//     }
//   ],
//   "spokenLanguages": [
//     {
//       "name": "English",
//       "nameEn": "English"
//     }
//   ],
//   "id": 1044004,
//   "type": "tv-series",
//   "name": "Ведьмак",
//   "description": "Ведьмак Геральт, мутант и убийца чудовищ, на своей верной лошади по кличке Плотва путешествует по Континенту. За тугой мешочек чеканных монет этот мужчина избавит вас от всякой настырной нечисти &#151; хоть от чудищ болотных, оборотней и даже заколдованных принцесс. В сельской глуши местную девушку Йеннифэр, которой сильно не повезло с внешностью, зато посчастливилось иметь способности к магии, отец продаёт колдунье в ученицы. А малолетняя наследница королевства Цинтра по имени Цири вынуждена пуститься в бега, когда их страну захватывает империя Нильфгаард. Судьбы этих троих окажутся тесно связаны, но скоро сказка сказывается, да не скоро дело делается.",
//   "distributors": {
//     "distributor": null,
//     "distributorRelease": null
//   },
//   "premiere": {
//     "world": "2019-12-20T00:00:00.000Z",
//     "digital": "2019-12-20T00:00:00.000Z"
//   },
//   "slogan": "The worst monsters are the ones we create.",
//   "year": 2019,
//   "poster": {
//     "url": "https://image.openmoviedb.com/kinopoisk-images/6201401/96a25d67-aa56-4496-bcac-1471e811582a/orig",
//     "previewUrl": "https://image.openmoviedb.com/kinopoisk-images/6201401/96a25d67-aa56-4496-bcac-1471e811582a/x1000"
//   },
//   "facts": [
//     {
//       "value": "Когда <a href=\"/name/34227/\" class=\"all\">Генри Кавилл</a> впервые услышал о будущих съёмках сериала, он начал теребить своих агентов, чтобы ему устроили встречу с продюсерами Netflix. Со временем встреча была организована, но создатель сериала <a href=\"/name/694780/\" class=\"all\">Лорен Шмидт Хиссрик</a> поначалу Кавилла отвергла. На роль Геральта впоследствии она просмотрела 207 актёров, но никто не подошёл. По мере написания сценария она всё время слышала голос Кавилла, произносящего реплики Геральта. В конце концов она устроила ещё одну встречу с актёром и сразу же поняла, что нашла искомое.",
//       "type": "FACT",
//       "spoiler": false
//     },
//     {
//       "value": "Готовясь к роли Геральта, <a href=\"/name/34227/\" class=\"all\">Генри Кавилл</a> много работал с мечом и наращивал мышечную массу.",
//       "type": "FACT",
//       "spoiler": false
//     },
//     {
//       "value": "По словам продюсера и шоураннера <a href=\"/name/694780/\" class=\"all\">Лорен Шмидт Хиссрик</a>, <a href=\"/name/34227/\" class=\"all\">Генри Кавилл</a> так, что называется, попадал в роль, что ему практически не требовалось читать реплики, написанные его персонажу.",
//       "type": "FACT",
//       "spoiler": false
//     },
//     {
//       "value": "Все свои трюки <a href=\"/name/34227/\" class=\"all\">Генри Кавилл</a> выполнял самостоятельно.",
//       "type": "FACT",
//       "spoiler": false
//     },
//     {
//       "value": "Зимой 2020 года во время съёмок второго сезона сериала <a href=\"/name/34227/\" class=\"all\">Генри Кавилл</a> повредил на бегу подколенное сухожилие. Несмотря на острую боль, актёр не нарушал съёмочного графика. Лечением травмы он занимался ранним утром, чтобы к 7:00 уже быть на съёмочной площадке.",
//       "type": "FACT",
//       "spoiler": false
//     },
//     {
//       "value": "Для постельных сцен <a href=\"/name/5214166/\" class=\"all\">Ане Чалотре</a>, которая сыграла Йеннифер, предложили дублёршу. Посмотрев на её работу, Чалотра вызвалась играть сама, но с условием, что снимать будут крупным планом и только выше пояса.",
//       "type": "FACT",
//       "spoiler": true
//     }
//   ],
//   "genres": [
//     {
//       "name": "фэнтези"
//     },
//     {
//       "name": "приключения"
//     },
//     {
//       "name": "драма"
//     },
//     {
//       "name": "ужасы"
//     }
//   ],
//   "countries": [
//     {
//       "name": "США"
//     },
//     {
//       "name": "Польша"
//     }
//   ],
//   "seasonsInfo": [
//     {
//       "number": 1,
//       "episodesCount": 8
//     },
//     {
//       "number": 2,
//       "episodesCount": 8
//     },
//     {
//       "number": 3,
//       "episodesCount": 8
//     },
//     {
//       "number": 4,
//       "episodesCount": 1
//     }
//   ],
//   "persons": [
//     {
//       "id": 34227,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_34227.jpg",
//       "name": "Генри Кавилл",
//       "enName": "Henry Cavill",
//       "description": "Geralt of Rivia",
//       "profession": "актеры",
//       "enProfession": "actor"
//     },
//     {
//       "id": 4632181,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_4632181.jpg",
//       "name": "Фрейя Аллан",
//       "enName": "Freya Allan",
//       "description": "Ciri",
//       "profession": "актеры",
//       "enProfession": "actor"
//     },
//     {
//       "id": 5214166,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_5214166.jpg",
//       "name": "Аня Чалотра",
//       "enName": "Anya Chalotra",
//       "description": "Yennefer",
//       "profession": "актеры",
//       "enProfession": "actor"
//     },
//     {
//       "id": 735378,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_735378.jpg",
//       "name": "Эймон Фэррен",
//       "enName": "Eamon Farren",
//       "description": "Cahir",
//       "profession": "актеры",
//       "enProfession": "actor"
//     },
//     {
//       "id": 3205712,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_3205712.jpg",
//       "name": "Мими М. Кайиса",
//       "enName": "Mimî M. Khayisa",
//       "description": "Fringilla",
//       "profession": "актеры",
//       "enProfession": "actor"
//     },
//     {
//       "id": 733439,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_733439.jpg",
//       "name": "МайАнна Бёринг",
//       "enName": "MyAnna Buring",
//       "description": "Tissaia",
//       "profession": "актеры",
//       "enProfession": "actor"
//     },
//     {
//       "id": 3040167,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_3040167.jpg",
//       "name": "Джои Бэти",
//       "enName": "Joey Batey",
//       "description": "Jaskier",
//       "profession": "актеры",
//       "enProfession": "actor"
//     },
//     {
//       "id": 3929254,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_3929254.jpg",
//       "name": "Уилсон Мбомио",
//       "enName": "Wilson Mbomio",
//       "description": null,
//       "profession": "актеры",
//       "enProfession": "actor"
//     },
//     {
//       "id": 1540954,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_1540954.jpg",
//       "name": "Анна Шаффер",
//       "enName": "Anna Shaffer",
//       "description": "Triss",
//       "profession": "актеры",
//       "enProfession": "actor"
//     },
//     {
//       "id": 2705231,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_2705231.jpg",
//       "name": "Ройс Пирресон",
//       "enName": "Royce Pierreson",
//       "description": "Istredd",
//       "profession": "актеры",
//       "enProfession": "actor"
//     },
//     {
//       "id": 1676506,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_1676506.jpg",
//       "name": "Джозеф Трапанезе",
//       "enName": "Joseph Trapanese",
//       "description": null,
//       "profession": "композиторы",
//       "enProfession": "composer"
//     },
//     {
//       "id": 2810691,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_2810691.jpg",
//       "name": "Соня Белоусова",
//       "enName": "Sonya Belousova",
//       "description": null,
//       "profession": "композиторы",
//       "enProfession": "composer"
//     },
//     {
//       "id": 2369888,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_2369888.jpg",
//       "name": "Джиона Остинелли",
//       "enName": "Giona Ostinelli",
//       "description": null,
//       "profession": "композиторы",
//       "enProfession": "composer"
//     },
//     {
//       "id": 571450,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_571450.jpg",
//       "name": "Эндрю Лоус",
//       "enName": "Andrew Laws",
//       "description": null,
//       "profession": "художники",
//       "enProfession": "designer"
//     },
//     {
//       "id": 1987127,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_1987127.jpg",
//       "name": "Стюарт Кернс",
//       "enName": "Stuart Kearns",
//       "description": null,
//       "profession": "художники",
//       "enProfession": "designer"
//     },
//     {
//       "id": 1989455,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_1989455.jpg",
//       "name": "Джастин Уорбёртон-Браун",
//       "enName": "Justin Warburton-Brown",
//       "description": null,
//       "profession": "художники",
//       "enProfession": "designer"
//     },
//     {
//       "id": 3398362,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_3398362.jpg",
//       "name": "Чантелл Валентайн",
//       "enName": "Chantelle Valentine",
//       "description": null,
//       "profession": "художники",
//       "enProfession": "designer"
//     },
//     {
//       "id": 110070,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_110070.jpg",
//       "name": "Стивен Серджик",
//       "enName": "Stephen Surjik",
//       "description": null,
//       "profession": "режиссеры",
//       "enProfession": "director"
//     },
//     {
//       "id": 612508,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_612508.jpg",
//       "name": "Алик Сахаров",
//       "enName": "Alik Sakharov",
//       "description": null,
//       "profession": "режиссеры",
//       "enProfession": "director"
//     },
//     {
//       "id": 105074,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_105074.jpg",
//       "name": "Шарлотта Брандстром",
//       "enName": "Charlotte Brändström",
//       "description": null,
//       "profession": "режиссеры",
//       "enProfession": "director"
//     },
//     {
//       "id": 2270775,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_2270775.jpg",
//       "name": "Алекс Гарсиа Лопес",
//       "enName": "Alex Garcia Lopez",
//       "description": null,
//       "profession": "режиссеры",
//       "enProfession": "director"
//     },
//     {
//       "id": 2022358,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_2022358.jpg",
//       "name": "Жан-Даниэль Фернандез-Кундез",
//       "enName": "Jean-Daniel Fernandez Qundez",
//       "description": null,
//       "profession": "монтажеры",
//       "enProfession": "editor"
//     },
//     {
//       "id": 1590779,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_1590779.jpg",
//       "name": "Ник Артурс",
//       "enName": "Nick Arthurs",
//       "description": null,
//       "profession": "монтажеры",
//       "enProfession": "editor"
//     },
//     {
//       "id": 2003849,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_2003849.jpg",
//       "name": "Лиана Дель Гьюдиче",
//       "enName": "Liana Del Giudice",
//       "description": null,
//       "profession": "монтажеры",
//       "enProfession": "editor"
//     },
//     {
//       "id": 3086190,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_3086190.jpg",
//       "name": "Майк Филлипс",
//       "enName": "Mike Phillips",
//       "description": null,
//       "profession": "монтажеры",
//       "enProfession": "editor"
//     },
//     {
//       "id": 687983,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_687983.jpg",
//       "name": "Жан-Филипп Госсар",
//       "enName": "Jean-Philippe Gossart",
//       "description": null,
//       "profession": "операторы",
//       "enProfession": "operator"
//     },
//     {
//       "id": 625972,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_625972.jpg",
//       "name": "Гэвин Стразерс",
//       "enName": "Gavin Struthers",
//       "description": null,
//       "profession": "операторы",
//       "enProfession": "operator"
//     },
//     {
//       "id": 868728,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_868728.jpg",
//       "name": "Ромейн Лакурбас",
//       "enName": "Romain Lacourbas",
//       "description": null,
//       "profession": "операторы",
//       "enProfession": "operator"
//     },
//     {
//       "id": 653744,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_653744.jpg",
//       "name": "Скотт Виниг",
//       "enName": "Scott Winig",
//       "description": null,
//       "profession": "операторы",
//       "enProfession": "operator"
//     },
//     {
//       "id": 559540,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_559540.jpg",
//       "name": "Джейсон Ф. Браун",
//       "enName": "Jason F. Brown",
//       "description": null,
//       "profession": "продюсеры",
//       "enProfession": "producer"
//     },
//     {
//       "id": 659876,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_659876.jpg",
//       "name": "Стив Гауб",
//       "enName": "Steve Gaub",
//       "description": null,
//       "profession": "продюсеры",
//       "enProfession": "producer"
//     },
//     {
//       "id": 859599,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_859599.jpg",
//       "name": "Томаш Багиньский",
//       "enName": "Tomasz Bagiński",
//       "description": null,
//       "profession": "продюсеры",
//       "enProfession": "producer"
//     },
//     {
//       "id": 1844,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_1844.jpg",
//       "name": "Шон Дэниэл",
//       "enName": "Sean Daniel",
//       "description": null,
//       "profession": "продюсеры",
//       "enProfession": "producer"
//     },
//     {
//       "id": 3399668,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_3399668.jpg",
//       "name": "Сергей Пономарёв",
//       "enName": null,
//       "description": null,
//       "profession": "актеры дубляжа",
//       "enProfession": "voice_actor"
//     },
//     {
//       "id": 2444078,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_2444078.jpg",
//       "name": "Александра Курагина",
//       "enName": null,
//       "description": null,
//       "profession": "актеры дубляжа",
//       "enProfession": "voice_actor"
//     },
//     {
//       "id": 1665278,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_1665278.jpg",
//       "name": "Вероника Саркисова",
//       "enName": null,
//       "description": null,
//       "profession": "актеры дубляжа",
//       "enProfession": "voice_actor"
//     },
//     {
//       "id": 1818938,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_1818938.jpg",
//       "name": "Даниил Эльдаров",
//       "enName": null,
//       "description": null,
//       "profession": "актеры дубляжа",
//       "enProfession": "voice_actor"
//     },
//     {
//       "id": 5711781,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_5711781.jpg",
//       "name": "Алёна Минчук",
//       "enName": null,
//       "description": null,
//       "profession": "актеры дубляжа",
//       "enProfession": "voice_actor"
//     },
//     {
//       "id": 7164077,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_7164077.jpg",
//       "name": null,
//       "enName": "Rae Benjamin",
//       "description": null,
//       "profession": "редакторы",
//       "enProfession": "writer"
//     },
//     {
//       "id": 3987514,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_3987514.jpg",
//       "name": "Майк Островски",
//       "enName": "Mike Ostrowski",
//       "description": null,
//       "profession": "редакторы",
//       "enProfession": "writer"
//     },
//     {
//       "id": 3388656,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_3388656.jpg",
//       "name": "Деклан Де Барра",
//       "enName": "Declan De Barra",
//       "description": null,
//       "profession": "редакторы",
//       "enProfession": "writer"
//     },
//     {
//       "id": 1786586,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_1786586.jpg",
//       "name": "Бо ДеМайо",
//       "enName": "Beau DeMayo",
//       "description": null,
//       "profession": "редакторы",
//       "enProfession": "writer"
//     }
//   ],
//   "lists": [
//     "popular-series"
//   ],
//   "typeNumber": 2,
//   "alternativeName": "The Witcher",
//   "enName": null,
//   "names": [
//     {
//       "name": "Ведьмак"
//     },
//     {
//       "name": "The Witcher"
//     },
//     {
//       "name": "巫师",
//       "language": "CN",
//       "type": null
//     },
//     {
//       "name": "Zaklínač",
//       "language": "CZ",
//       "type": null
//     },
//     {
//       "name": "Ο Γητευτής",
//       "language": "GR",
//       "type": null
//     },
//     {
//       "name": "Vaják",
//       "language": "HU",
//       "type": null
//     },
//     {
//       "name": "Wiedźmin",
//       "language": "PL",
//       "type": null
//     },
//     {
//       "name": "Zaklínač",
//       "language": "SK",
//       "type": null
//     },
//     {
//       "name": "เดอะ วิทเชอร์ นักล่าจอมอสูร",
//       "language": "TH",
//       "type": null
//     },
//     {
//       "name": "Thợ Săn Quái Vật",
//       "language": "VN",
//       "type": null
//     }
//   ],
//   "movieLength": null,
//   "ratingMpaa": null,
//   "shortDescription": null,
//   "technology": {
//     "hasImax": false,
//     "has3D": false
//   },
//   "ticketsOnSale": false,
//   "updatedAt": "2024-03-16T01:07:12.685Z",
//   "similarMovies": [],
//   "fees": {
//     "world": {},
//     "russia": {},
//     "usa": {}
//   },
//   "sequelsAndPrequels": [],
//   "ageRating": 18,
//   "logo": {
//     "url": "https://imagetmdb.com/t/p/original/tZR8BERsQa8ZXpGxb9x3PuR6RQU.png"
//   },
//   "budget": {},
//   "watchability": {
//     "items": []
//   },
//   "releaseYears": [
//     {
//       "start": 2019,
//       "end": null
//     }
//   ],
//   "top10": null,
//   "top250": null,
//   "deletedAt": null,
//   "isSeries": true,
//   "seriesLength": 60,
//   "totalSeriesLength": 474,
//   "networks": {
//     "items": [
//       {
//         "name": "Netflix"
//       }
//     ]
//   },
//   "videos": {
//     "trailers": [
//       {
//         "url": "https://www.youtube.com/embed/Xtf3c-Y20Lw",
//         "name": "Ведьмак (1 сезон) — Русский трейлер (Озвучка, 2019)",
//         "site": "youtube",
//         "type": "TRAILER"
//       },
//       {
//         "url": "https://www.youtube.com/embed/Xtf3c-Y20Lw",
//         "name": "Ведьмак (1 сезон) — Русский трейлер (Озвучка, 2019)",
//         "site": "youtube",
//         "type": "TRAILER"
//       },
//       {
//         "url": "https://www.youtube.com/embed/eb90gqGYP9c",
//         "name": "Final Trailer",
//         "site": "youtube",
//         "type": "TRAILER"
//       },
//       {
//         "url": "https://www.youtube.com/embed/ndl1W4ltcmg",
//         "name": "Main Trailer",
//         "site": "youtube",
//         "type": "TRAILER"
//       }
//     ]
//   }
// }