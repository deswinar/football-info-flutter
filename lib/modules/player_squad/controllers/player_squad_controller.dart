import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/modules/player_squad/models/player_entry.dart';
import 'package:football_app/modules/player_squad/repositories/player_squad_repository.dart';
import 'package:get/get.dart';

class PlayerSquadController extends GetxController {
  final PlayerSquadRepository _playerSquadRepository;

  PlayerSquadController(this._playerSquadRepository);

  final _squadState = Rx<ViewState<List<PlayerEntry>>>(ViewStateInitial());
  get squadState => _squadState.value;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    final int teamId = args['teamId'];
    fetchSquad(teamId: teamId); // default team ID
  }

  Future<void> fetchSquad({required int teamId}) async {
    _squadState.value = const ViewStateLoading();

    try {
      final players = await _playerSquadRepository.getSquadByTeamId(teamId);
      _squadState.value = ViewStateSuccess(players);
    } catch (e) {
      _squadState.value = ViewStateError(e.toString());
    }
  }

  Future<void> refreshSquad({required int teamId}) async {
    await fetchSquad(teamId: teamId);
  }
}
