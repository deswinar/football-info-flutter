class TeamEntry {
  final Team team;
  final Venue venue;

  TeamEntry({required this.team, required this.venue});

  factory TeamEntry.fromJson(Map<String, dynamic> json) {
    return TeamEntry(
      team: Team.fromJson(json['team']),
      venue: Venue.fromJson(json['venue']),
    );
  }
}

class Team {
  final int id;
  final String name;
  final String? code;
  final String country;
  final int? founded;
  final bool national;
  final String logo;

  Team({
    required this.id,
    required this.name,
    this.code,
    required this.country,
    this.founded,
    required this.national,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      country: json['country'],
      founded: json['founded'],
      national: json['national'],
      logo: json['logo'],
    );
  }
}

class Venue {
  final int? id;
  final String? name;
  final String? address;
  final String? city;
  final int? capacity;
  final String? surface;
  final String? image;

  Venue({
    this.id,
    this.name,
    this.address,
    this.city,
    this.capacity,
    this.surface,
    this.image,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      capacity: json['capacity'],
      surface: json['surface'],
      image: json['image'],
    );
  }
}
