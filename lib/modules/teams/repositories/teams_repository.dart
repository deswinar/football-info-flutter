import 'package:football_app/core/services/api_client.dart';
import 'package:football_app/core/utils/api_utils.dart';
import 'package:football_app/modules/teams/models/team_entry.dart';
import 'package:football_app/modules/teams/models/team_response.dart';

class TeamsRepository {
  final ApiClient _apiClient;

  TeamsRepository(this._apiClient);

  // Get all teams in a specific league and season
  Future<List<TeamEntry>> getTeamsByLeagueAndSeason({
    required int leagueId,
    required int season,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/teams',
      query: {
        'league': leagueId,
        'season': season,
      },
    );

    // Check for 'errors' key
    checkForApiError(response.data, statusCode: response.statusCode);

    final teamResponse = TeamResponse.fromJson(response.data!);
    return teamResponse.response;
  }

  // Get details of a specific team by teamId
  Future<TeamEntry> getTeamById(int teamId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/teams',
      query: {
        'id': teamId,
      },
    );

    final teamResponse = TeamResponse.fromJson(response.data!);
    if (teamResponse.response.isNotEmpty) {
      return teamResponse.response.first;
    } else {
      throw Exception('Team not found');
    }
  }
}
