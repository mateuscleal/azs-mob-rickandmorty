import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:app/ui/home_episodes/view_models/episodes_view_model.dart';
import 'package:app/ui/main_scaffold/view_models/main_scaffold_view_model.dart';
import 'package:app/ui/main_scaffold/widgets/bottom_nav_bar_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class MainScaffoldScreen extends StatelessWidget {
  MainScaffoldScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScaffoldViewModel>(
      builder: (_, viewModel, child) {
        return Consumer<EpisodesViewModel>(
          builder: (_, episodesViewModel, child) {
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                toolbarHeight: 80,
                backgroundColor: AppColors.background,
                foregroundColor: AppColors.primary,
                title: Image.asset(viewModel.titles[viewModel.currentIndex], width: 200),
                centerTitle: true,
                actions: [
                  Visibility(
                    visible: viewModel.currentIndex == 1,
                    child: SearchBarAnimation(
                      enableBoxBorder: true,
                      enableButtonBorder: true,
                      isOriginalAnimation: false,
                      hintText: 'Search episodes by name',
                      searchBoxWidth: MediaQuery.of(context).size.width - 10,
                      textEditingController: TextEditingController(),
                      searchBoxBorderColour: AppColors.accent,
                      searchBoxColour: AppColors.background,
                      buttonBorderColour: AppColors.accent,
                      buttonColour: AppColors.background,
                      cursorColour: Colors.white,
                      trailingWidget: Icon(Icons.rocket_launch_outlined, color: Colors.grey),
                      buttonWidget: Icon(Icons.search_outlined, color: AppColors.secondary),
                      secondaryButtonWidget: Icon(Icons.close_outlined, color: AppColors.secondary),
                      enteredTextStyle: TextStyle(color: AppColors.textPrimary),
                      enableKeyboardFocus: true,
                      onChanged: (String value) {},
                      onFieldSubmitted: (String value) async {
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        final flag = await episodesViewModel.filterEpisodes(value);
                        if (!flag) {
                          scaffoldMessenger.clearSnackBars();
                          scaffoldMessenger.showSnackBar(
                            SnackBar(backgroundColor: Colors.red, content: Text('No results found')),
                          );
                        }
                      },
                      onCollapseComplete: () => episodesViewModel.filterEpisodes(''),
                    ),
                  ),
                ],
              ),
              body: viewModel.currentView,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Container(
                height: 60,
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(color: Colors.black54, spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        episodesViewModel.filterEpisodes('');
                        viewModel.getIndex(0);
                      },
                      child: BottomNavBarItems(
                        width: 75,
                        isSelected: viewModel.currentIndex == 0,
                        title: 'Locations',
                        icon: Icons.public,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        episodesViewModel.filterEpisodes('');
                        viewModel.getIndex(1);
                      },
                      child: BottomNavBarItems(
                        width: 75,
                        isSelected: viewModel.currentIndex == 1,
                        title: 'Home',
                        icon: Icons.home,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        episodesViewModel.filterEpisodes('');
                        viewModel.getIndex(2);
                      },
                      child: BottomNavBarItems(
                        width: 75,
                        isSelected: viewModel.currentIndex == 2,
                        title: 'Favorites',
                        icon: Icons.favorite,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
