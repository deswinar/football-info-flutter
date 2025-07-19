import 'package:football_app/core/services/api_client.dart';
import 'package:football_app/core/utils/api_utils.dart';
import 'package:football_app/modules/players/models/player_response.dart';

class PlayerRepository {
  final ApiClient _apiClient;

  PlayerRepository(this._apiClient);

  // Fetch all players with pagination and optional search
  Future<PlayerProfileResponse> getAllPlayers({
    int page = 1,
    String? search,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/players/profiles',
      query: {
        'page': page,
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );

    checkForApiError(response.data, statusCode: response.statusCode);

    return PlayerProfileResponse.fromJson(response.data!);
  }
}
