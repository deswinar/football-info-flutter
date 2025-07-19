import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/modules/player_squad/models/player_entry.dart';
import 'package:football_app/modules/players/repositories/player_repository.dart';
import 'package:get/get.dart';

class PlayerController extends GetxController {
  final PlayerRepository _playerRepository;

  PlayerController(this._playerRepository);

  final _playersState = Rx<ViewState<List<PlayerEntry>>>(ViewStateInitial());
  get playersState => _playersState.value;

  final List<PlayerEntry> _players = [];
  List<PlayerEntry> get players => _players;

  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoadingMore = false;

  final RxString _searchQuery = ''.obs;
  String get searchQuery => _searchQuery.value;

  bool get hasMore => _currentPage < _totalPages;
  bool get isLoadingMore => _isLoadingMore;

  @override
  void onInit() {
    super.onInit();

    // Debounce search query
    debounce<String>(_searchQuery, (query) {
      fetchPlayers(reset: true);
    }, time: const Duration(milliseconds: 500));

    fetchPlayers(reset: true);
  }

  Future<void> fetchPlayers({bool reset = false}) async {
    if (reset) {
      _currentPage = 1;
      _players.clear();
      _playersState.value = const ViewStateLoading();
    } else {
      _isLoadingMore = true;
    }

    try {
      final response = await _playerRepository.getAllPlayers(
        page: _currentPage,
        search: _searchQuery.value.isNotEmpty ? _searchQuery.value : null,
      );

      _totalPages = response.totalPages;
      _players.addAll(response.players);

      _playersState.value = ViewStateSuccess(List<PlayerEntry>.from(_players));
      _currentPage++;
    } catch (e) {
      if (reset) {
        _playersState.value = ViewStateError(e.toString());
      }
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> refreshPlayers() async {
    await fetchPlayers(reset: true);
  }

  Future<void> loadMore() async {
    if (hasMore && !_isLoadingMore) {
      await fetchPlayers();
    }
  }

  void searchPlayers(String query) {
    _searchQuery.value = query.trim();
  }
}
