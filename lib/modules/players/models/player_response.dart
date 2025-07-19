import 'package:football_app/modules/player_squad/models/player_entry.dart';

class PlayerProfileResponse {
  final List<PlayerEntry> players;
  final int currentPage;
  final int totalPages;

  PlayerProfileResponse({
    required this.players,
    required this.currentPage,
    required this.totalPages,
  });

  factory PlayerProfileResponse.fromJson(Map<String, dynamic> json) {
    final responseList = json['response'] as List;

    return PlayerProfileResponse(
      players: responseList.map((e) => PlayerEntry.fromJson(e['player'])).toList(),
      currentPage: json['paging']['current'] ?? 1,
      totalPages: json['paging']['total'] ?? 1,
    );
  }
}
