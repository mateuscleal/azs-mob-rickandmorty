import 'package:app/data/graphql/graphql_queries.dart';
import 'package:app/data/services/graphql_service.dart';
import 'package:flutter/material.dart';

class LocationsViewModel extends ChangeNotifier {

  final GraphQLService _graphqlService = GraphQLService();


  int _idReference = 0;
  List<dynamic> _locations = [];


  int get idReference => _idReference;
  List<dynamic> get locations => _locations;

  Future<void> fetchLocations() async {
    final query = queries['getLocations'];
    try {
      final result = await _graphqlService.executeQuery(query);
      if (result.hasException) throw result.exception!;
      _locations = result.data?['locations']['results'] ?? [];
    } catch (e) {
      debugPrint("Error fetching locations: $e");
    }
  }

  void setReference(int id) {
    _idReference = id;
    notifyListeners();
  }

}