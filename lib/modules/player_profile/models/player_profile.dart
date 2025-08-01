class PlayerProfile {
  final int? id;
  final String? name;
  final String? firstname;
  final String? lastname;
  final int? age;
  final String? birthDate;
  final String? birthPlace;
  final String? birthCountry;
  final String? nationality;
  final String? height;
  final String? weight;
  final int? number;
  final String? position;
  final String? photo;

  PlayerProfile({
    this.id,
    this.name,
    this.firstname,
    this.lastname,
    this.age,
    this.birthDate,
    this.birthPlace,
    this.birthCountry,
    this.nationality,
    this.height,
    this.weight,
    this.number,
    this.position,
    this.photo,
  });

  factory PlayerProfile.fromJson(Map<String, dynamic> json) {
    return PlayerProfile(
      id: json['id'],
      name: json['name'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      age: json['age'],
      birthDate: json['birth']?['date'],
      birthPlace: json['birth']?['place'],
      birthCountry: json['birth']?['country'],
      nationality: json['nationality'],
      height: json['height'],
      weight: json['weight'],
      number: json['number'],
      position: json['position'],
      photo: json['photo'],
    );
  }
}
