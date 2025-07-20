import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/modules/teams/models/team_entry.dart';
import 'package:football_app/modules/teams/repositories/teams_repository.dart';
import 'package:get/get.dart';

class TeamsController extends GetxController {
  final TeamsRepository _teamsRepository;

  TeamsController(this._teamsRepository);

  final _teamsState = Rx<ViewState<List<TeamEntry>>>(ViewStateInitial());
  get teamsState => _teamsState.value;

  @override
  void onInit() {
    super.onInit();
    // fetchTeams(leagueId: 39, season: 2021); // default league & season
  }

  Future<void> fetchTeams({
    required int leagueId,
    required int season,
  }) async {
    _teamsState.value = const ViewStateLoading();

    try {
      final data = await _teamsRepository.getTeamsByLeagueAndSeason(
        leagueId: leagueId,
        season: season,
      );

      _teamsState.value = ViewStateSuccess(data);
    } catch (e) {
      _teamsState.value = ViewStateError(e.toString());
    }
  }

  Future<void> refreshTeams({
    required int leagueId,
    required int season,
  }) async {
    await fetchTeams(leagueId: leagueId, season: season);
  }
}
