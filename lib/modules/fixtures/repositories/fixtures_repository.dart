import 'package:football_app/core/services/api_client.dart';
import 'package:football_app/core/utils/api_utils.dart';
import 'package:football_app/modules/fixtures/models/fixture_response.dart';

class FixturesRepository {
  final ApiClient _apiClient;

  FixturesRepository(this._apiClient);

  // Fetch fixtures for a specific date in yyyy-MM-dd format
  Future<List<FixtureEntry>> getFixturesByDate(String date) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/fixtures',
      query: {
        'date': date,
        'timezone': 'Asia/Jakarta',
      },
    );

    final fixtureResponse = FixtureResponse.fromJson(response.data!);
    return fixtureResponse.response;
  }

  // Fetch live fixtures (ongoing matches)
  Future<List<FixtureEntry>> getLiveFixtures() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/fixtures',
      query: {
        'live': 'all',
        'timezone': 'Asia/Jakarta',
      },
    );

    final fixtureResponse = FixtureResponse.fromJson(response.data!);
    return fixtureResponse.response;
  }

  // Fetch fixtures by league and season
  Future<List<FixtureEntry>> getFixturesByLeagueAndSeason({
    required int leagueId,
    required int season,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/fixtures',
      query: {
        'league': leagueId,
        'season': season,
      },
    );

    // Check for 'errors' key
    checkForApiError(response.data, statusCode: response.statusCode);

    final fixtureResponse = FixtureResponse.fromJson(response.data!);
    return fixtureResponse.response;
  }
}
