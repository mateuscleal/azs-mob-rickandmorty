import 'package:app/routing/app_routes.dart';
import 'package:app/ui/home_episodes/view_models/episodes_view_model.dart';
import 'package:app/ui/favorites/widgets/simple_episode_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Consumer<EpisodesViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (viewModel.favoriteEpisodes.isEmpty) {
            return const Center(
              child: Text('No episodes marked as favorites.', style: TextStyle(color: Colors.white)),
            );
          }
          return Column(
            children: [
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.favoriteEpisodes.length + 1,
                  itemBuilder: (context, index) {
                    if (index == viewModel.favoriteEpisodes.length) {
                      return SizedBox(height: 80);
                    }
                    final favoriteEpisodes = viewModel.favoriteEpisodes[index];
                    return GestureDetector(
                      onTap: () {
                        viewModel.setReference(int.parse(favoriteEpisodes['id']) - 1);
                        Navigator.of(context).pushNamed(AppRoutes.episodeDetails);
                      },
                      child: SimpleEpisodeCard(
                        title: favoriteEpisodes['name'],
                        date: favoriteEpisodes['air_date'],
                        episode: favoriteEpisodes['episode'],
                        imagePath: favoriteEpisodes['imagePath'],
                        numberCharacters: favoriteEpisodes['characters'].length.toString(),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
