import 'package:football_app/core/services/api_client.dart';
import 'package:football_app/core/utils/api_utils.dart';
import 'package:football_app/modules/player_squad/models/player_entry.dart';
import 'package:football_app/modules/player_squad/models/player_squad_response.dart';

class PlayerSquadRepository {
  final ApiClient _apiClient;

  PlayerSquadRepository(this._apiClient);

  // Fetch all players (squad) for a given team
  Future<List<PlayerEntry>> getSquadByTeamId(int teamId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/players/squads',
      query: {
        'team': teamId,
      },
    );

    // Check for 'errors' key
    checkForApiError(response.data, statusCode: response.statusCode);

    final squadResponse = PlayerSquadResponse.fromJson(response.data!);

    if (squadResponse.response.isEmpty) {
      return [];
    }

    return squadResponse.response.first.players;
  }
}
