import 'package:app/routing/app_routes.dart';
import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:app/ui/locations/view_models/locations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationsViewModel>(
      builder: (_, viewModel, child) {
        return Column(
          children: [
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: viewModel.locations.length + 1,
                itemBuilder: (context, index) {
                  if (index == viewModel.locations.length) {
                    return SizedBox(height: 90);
                  }
                  return GestureDetector(
                    onTap: () {
                      viewModel.setReference(int.parse(viewModel.locations[index]['id']) - 1);
                      Navigator.of(context).pushNamed(AppRoutes.locationsResidents);
                    },
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.public, size: 40, color: AppColors.primary),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Type: ${viewModel.locations[index]['type']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Dimension: ${viewModel.locations[index]['dimension']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                Text(
                                  'Number Residents: ${viewModel.locations[index]['residents'].length}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
