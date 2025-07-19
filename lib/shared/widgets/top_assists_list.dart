import 'package:flutter/material.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/modules/home/controllers/home_controller.dart';
import 'package:football_app/shared/data/responses/top_assist_response.dart';
import 'package:football_app/shared/controllers/top_assists_controller.dart';
import 'package:football_app/shared/widgets/top_assist_player_card.dart';
import 'package:football_app/shared/widgets/player_card_skeleton.dart';
import 'package:football_app/shared/widgets/view_state_error_widget.dart';
import 'package:get/get.dart';

class TopAssistsList extends StatelessWidget {
  const TopAssistsList({
    super.key,
    required this.topAssistsController,
  });

  final TopAssistsController topAssistsController;

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    final leagueId = homeController.leagueId.value;
    final season = homeController.seasonYear.value;
    
    return Obx(() {
      final state = topAssistsController.topAssistsState;
      if (state is ViewStateLoading) {
        return SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (_, __) => const PlayerCardSkeleton(),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
          ),
        );
      } else if (state is ViewStateError) {
        return ViewStateErrorWidget(
          message: state.message,
          onRetry: () => topAssistsController.fetchTopAssists(leagueId: leagueId, season: season),
        );
      } else if (state is ViewStateSuccess<List<TopAssistResponse>>) {
        final players = state.data;
        if (players.isEmpty) {
          return const Text('No data available.');
        }

        return SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: players.length,
            itemBuilder: (_, i) => TopAssistPlayerCard(player: players[i]),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
