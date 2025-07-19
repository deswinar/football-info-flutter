import 'package:football_app/shared/data/responses/top_scorer_response.dart';
import 'package:football_app/shared/data/responses/top_assist_response.dart';

class TopPlayerStat {
  final String name;
  final String photo;
  final int statValue;
  final String label; // e.g., "Goals" or "Assists"

  TopPlayerStat({
    required this.name,
    required this.photo,
    required this.statValue,
    required this.label,
  });
}

extension TopScorerExtension on TopScorerResponse {
  TopPlayerStat toTopPlayerStat() {
    return TopPlayerStat(
      name: player.name,
      photo: player.photo,
      statValue: statistics.first.goals['total'] ?? 0,
      label: 'Goals',
    );
  }
}

extension TopAssistExtension on TopAssistResponse {
  TopPlayerStat toTopPlayerStat() {
    return TopPlayerStat(
      name: player.name,
      photo: player.photo,
      statValue: statistics.first.goals['assists'] ?? 0,
      label: 'Assists',
    );
  }
}
