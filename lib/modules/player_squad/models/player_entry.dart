class PlayerEntry {
  final int id;
  final String? name;
  final int? age;
  final int? number;
  final String? position;
  final String? photo;

  PlayerEntry({
    required this.id,
    this.name,
    this.age,
    this.number,
    this.position,
    this.photo,
  });

  factory PlayerEntry.fromJson(Map<String, dynamic> json) {
    return PlayerEntry(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      number: json['number'] ?? 0,
      position: json['position'] ?? '',
      photo: json['photo'] ?? '',
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
