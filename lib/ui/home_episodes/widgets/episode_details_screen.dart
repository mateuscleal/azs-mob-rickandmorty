import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:app/ui/home_episodes/view_models/episodes_view_model.dart';
import 'package:app/ui/home_episodes/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EpisodeDetailsScreen extends StatelessWidget {
  const EpisodeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodesViewModel>(
      builder: (_, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 65,
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.primary,
            title: Image.asset('assets/images/episode_details.png', width: 125),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.grey.shade800, spreadRadius: 1, blurRadius: 7)],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      image: NetworkImage('${viewModel.episodes[viewModel.idReference]['imagePath']}'),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 225,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    '${viewModel.episodes[viewModel.idReference]['name']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '${viewModel.episodes[viewModel.idReference]['air_date']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.accent),
                            ),
                            child: Center(
                              child: Text(
                                '${viewModel.episodes[viewModel.idReference]['episode']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(margin: EdgeInsets.symmetric(horizontal: 10), child: Divider()),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/characters.png', width: 170),
                      Text(
                        'N°: ${viewModel.episodes[viewModel.idReference]['characters'].length}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.episodes[viewModel.idReference]['characters'].length,
                    itemBuilder: (_, index) {
                      final character = viewModel.episodes[viewModel.idReference]['characters'][index];
                      return CharacterCard(
                        imagePath: character['image'],
                        name: character['name'],
                        status: character['status'],
                        species: character['species'],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
