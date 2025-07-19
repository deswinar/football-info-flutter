import 'player_entry.dart';

class PlayerSquadResponse {
  final List<SquadResponse> response;

  PlayerSquadResponse({required this.response});

  factory PlayerSquadResponse.fromJson(Map<String, dynamic> json) {
    return PlayerSquadResponse(
      response: (json['response'] as List)
          .map((item) => SquadResponse.fromJson(item))
          .toList(),
    );
  }
}

class SquadResponse {
  final TeamMeta team;
  final List<PlayerEntry> players;

  SquadResponse({
    required this.team,
    required this.players,
  });

  factory SquadResponse.fromJson(Map<String, dynamic> json) {
    return SquadResponse(
      team: TeamMeta.fromJson(json['team']),
      players: (json['players'] as List)
          .map((p) => PlayerEntry.fromJson(p))
          .toList(),
    );
  }
}

class TeamMeta {
  final int id;
  final String name;
  final String logo;

  TeamMeta({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory TeamMeta.fromJson(Map<String, dynamic> json) {
    return TeamMeta(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }
}
