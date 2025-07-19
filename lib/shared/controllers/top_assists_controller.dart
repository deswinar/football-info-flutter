import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/shared/data/repositories/player_stats_repository.dart';
import 'package:football_app/shared/data/responses/top_assist_response.dart';
import 'package:get/get.dart';

class TopAssistsController extends GetxController {
  final PlayerStatsRepository _playerStatsRepository;

  TopAssistsController(this._playerStatsRepository);

  final _topAssistsState = Rx<ViewState<List<TopAssistResponse>>>(ViewStateInitial());
  get topAssistsState => _topAssistsState.value;

  @override
  void onInit() {
    super.onInit();
    fetchTopAssists(leagueId: 39, season: 2021); // default values
  }

  Future<void> fetchTopAssists({
    required int leagueId,
    required int season,
  }) async {
    _topAssistsState.value = const ViewStateLoading();

    try {
      final data = await _playerStatsRepository.getTopAssists(
        leagueId: leagueId,
        season: season,
      );

      _topAssistsState.value = ViewStateSuccess(data);
    } catch (e) {
      _topAssistsState.value = ViewStateError(e.toString());
    }
  }

  Future<void> refreshTopAssists({
    required int leagueId,
    required int season,
  }) async {
    await fetchTopAssists(leagueId: leagueId, season: season);
  }
}
