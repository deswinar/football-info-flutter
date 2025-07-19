import 'package:football_app/core/services/api_client.dart';
import 'package:football_app/core/utils/api_utils.dart';
import 'package:football_app/modules/player_profile/models/player_profile.dart';

class PlayerProfileRepository {
  final ApiClient _apiClient;

  PlayerProfileRepository(this._apiClient);

  Future<PlayerProfile> getPlayerProfile(int playerId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/players/profiles',
      query: {'player': playerId},
    );

    // Check for 'errors' key
    checkForApiError(response.data, statusCode: response.statusCode);

    final data = response.data?['response'];
    if (data == null || data.isEmpty) {
      throw Exception('Player profile not found');
    }

    return PlayerProfile.fromJson(data.first['player']);
  }
}
