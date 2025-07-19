class PlayerEntry {
  final int id;
  final String name;
  final int age;
  final int? number;
  final String position;
  final String photo;

  PlayerEntry({
    required this.id,
    required this.name,
    required this.age,
    this.number,
    required this.position,
    required this.photo,
  });

  factory PlayerEntry.fromJson(Map<String, dynamic> json) {
    return PlayerEntry(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      number: json['number'], // Nullable
      position: json['position'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'number': number,
      'position': position,
      'photo': photo,
    };
  }
}
