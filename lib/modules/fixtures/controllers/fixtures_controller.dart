import 'package:football_app/core/enums/fixture_sort_options.dart';
import 'package:football_app/modules/fixtures/repositories/fixtures_repository.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:football_app/modules/fixtures/models/fixture_response.dart';

class FixturesController extends GetxController {
  final FixturesRepository _repository;

  FixturesController(this._repository);

  final _fixturesState = Rx<ViewState<List<FixtureEntry>>>(ViewStateInitial());
  get fixturesState => _fixturesState.value;

  final selectedDate = DateTime.now().obs;

  final searchQuery = ''.obs;
  final selectedSort = FixtureSortOption.dateAsc.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFixturesByLeagueAndSeason(leagueId: 39, season: 2021);
  }

  // Filtered list based on search
  List<FixtureEntry> get filteredFixtures {
    if (_fixturesState.value is! ViewStateSuccess<List<FixtureEntry>>) return [];

    final allFixtures = (_fixturesState.value as ViewStateSuccess<List<FixtureEntry>>).data;
    final query = searchQuery.value.toLowerCase();

    List<FixtureEntry> filtered = allFixtures.where((entry) {
      final home = entry.teams.home?.name?.toLowerCase() ?? '';
      final away = entry.teams.away?.name?.toLowerCase() ?? '';
      final venue = entry.fixture.venue?.name?.toLowerCase() ?? '';
      final status = entry.fixture.status?.long?.toLowerCase() ?? '';

      return home.contains(query) ||
             away.contains(query) ||
             venue.contains(query) ||
             status.contains(query);
    }).toList();

    // Sort based on selectedSort
    filtered.sort((a, b) {
      switch (selectedSort.value) {
        case FixtureSortOption.dateAsc:
          return a.fixture.date!.compareTo(b.fixture.date!);
        case FixtureSortOption.dateDesc:
          return b.fixture.date!.compareTo(a.fixture.date!);
        case FixtureSortOption.homeTeam:
          return (a.teams.home?.name ?? '').compareTo(b.teams.home?.name ?? '');
        case FixtureSortOption.awayTeam:
          return (a.teams.away?.name ?? '').compareTo(b.teams.away?.name ?? '');
        case FixtureSortOption.venue:
          return (a.fixture.venue?.name ?? '').compareTo(b.fixture.venue?.name ?? '');
      }
    });

    return filtered;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void setSortOption(FixtureSortOption option) => selectedSort.value = option;

  String get formattedDate => DateFormat('yyyy-MM-dd').format(selectedDate.value);

  Future<void> fetchFixturesByDate(DateTime date) async {
    _fixturesState.value = const ViewStateLoading();
    try {
      final fixtures = await _repository.getFixturesByDate(
        DateFormat('yyyy-MM-dd').format(date),
      );
      _fixturesState.value = ViewStateSuccess(fixtures);
    } catch (e) {
      _fixturesState.value = ViewStateError(e.toString());
    }
  }

  Future<void> fetchFixturesByLeagueAndSeason({
    required int leagueId,
    required int season,
  }) async {
    _fixturesState.value = const ViewStateLoading();
    try {
      final fixtures = await _repository.getFixturesByLeagueAndSeason(
        leagueId: leagueId,
        season: season,
      );
      _fixturesState.value = ViewStateSuccess(fixtures);
    } catch (e) {
      _fixturesState.value = ViewStateError(e.toString());
    }
  }

  Future<void> fetchLiveFixtures() async {
    _fixturesState.value = const ViewStateLoading();
    try {
      final fixtures = await _repository.getLiveFixtures();
      _fixturesState.value = ViewStateSuccess(fixtures);
    } catch (e) {
      _fixturesState.value = ViewStateError(e.toString());
    }
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
    fetchFixturesByDate(date);
  }
}
