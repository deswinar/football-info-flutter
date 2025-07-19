import 'package:football_app/modules/teams/models/team_entry.dart';

class TeamResponse {
  final List<TeamEntry> response;

  TeamResponse({required this.response});

  factory TeamResponse.fromJson(Map<String, dynamic> json) {
    return TeamResponse(
      response: (json['response'] as List)
          .map((e) => TeamEntry.fromJson(e))
          .toList(),
    );
  }
}
