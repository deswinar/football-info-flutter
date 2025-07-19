import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/modules/player_profile/models/player_profile.dart';
import 'package:football_app/modules/player_profile/repositories/player_profile_repository.dart';
import 'package:get/get.dart';

class PlayerProfileController extends GetxController {
  final PlayerProfileRepository _repository;

  PlayerProfileController(this._repository);

  final _profileState = Rx<ViewState<PlayerProfile>>(ViewStateInitial());
  get profileState => _profileState.value;

  Future<void> fetchPlayerProfile(int playerId) async {
    _profileState.value = const ViewStateLoading();

    try {
      final profile = await _repository.getPlayerProfile(playerId);
      _profileState.value = ViewStateSuccess(profile);
    } catch (e) {
      _profileState.value = ViewStateError(e.toString());
    }
  }
}
