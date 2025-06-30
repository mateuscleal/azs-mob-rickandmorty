import 'package:app/ui/home_episodes/view_models/episodes_view_model.dart';
import 'package:app/ui/locations/view_models/locations_view_model.dart';
import 'package:app/ui/main_scaffold/view_models/main_scaffold_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => MainScaffoldViewModel()),
  ChangeNotifierProvider(create: (_) => EpisodesViewModel()),
  ChangeNotifierProvider(create: (_) => LocationsViewModel()),
];
