class ActorModel {
  final String photo;
  final String name;
  final String profession;

  ActorModel({
    required this.photo,
    required this.name,
    required this.profession,
  });
  factory ActorModel.fromJSON(Map<String, dynamic> json) => ActorModel(
        photo: json['photo'] ?? '',
        name: json['name'] ?? json['enName'] ?? '',
        profession: json['profession'] ?? '',
      );

  Map<String, dynamic> toJson() {
    return {
      'photo': photo,
      'name': name,
      'profession': profession,
    };
  }
}
//       "id": 34227,
//       "photo": "https://st.kp.yandex.net/images/actor_iphone/iphone360_34227.jpg",
//       "name": "Генри Кавилл",
//       "enName": "Henry Cavill",
//       "profession": "актеры",
//       "enProfession": "actor"
