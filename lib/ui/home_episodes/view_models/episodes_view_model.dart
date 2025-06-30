import 'dart:math';

import 'package:app/data/graphql/graphql_queries.dart';
import 'package:app/data/services/graphql_service.dart';
import 'package:app/data/services/hive_service.dart';
import 'package:flutter/material.dart';

class EpisodesViewModel extends ChangeNotifier {
  final GraphQLService _graphqlService = GraphQLService();

  int _idReference = 0;
  bool _isLoading = false;
  List<dynamic> _allEpisodes = [];
  List<dynamic> _filteredEpisodes = [];
  final List<dynamic> _favoriteEpisodes = [];

  bool get isLoading => _isLoading;

  int get idReference => _idReference;

  List<dynamic> get favoriteEpisodes => _favoriteEpisodes;

  List<dynamic> get episodes => _filteredEpisodes.isEmpty ? _allEpisodes : _filteredEpisodes;

  Future<void> fetchEpisodes() async {
    final query = queries['getEpisodes'];
    try {
      final result = await _graphqlService.executeQuery(query);
      if (result.hasException) {
        throw result.exception!;
      }

      _allEpisodes = await (result.data?['episodes']['results'] ?? []).map((episode) {
        final randomIndex = Random().nextInt(episode['characters'].length);
        final index = int.parse(episode['id']) - 1;
        bool isFavorite = HiveManager.listKv[index] != null ? HiveManager.listKv[index]![0] : false;
        bool isWatched = HiveManager.listKv[index] != null ? HiveManager.listKv[index]![1] : false;
        final episodeData = {
          ...episode,
          'imagePath': episode['characters'][randomIndex]['image'],
          'isWatched': isWatched,
          'isFavorite': isFavorite,
        };
        if (isFavorite) {
          _favoriteEpisodes.add(episodeData);
        }
        return episodeData;
      }).toList();
    } catch (e) {
      debugPrint("Error fetching episodes: $e");
    }
  }

  void setReference(int id) {
    _idReference = id;
    notifyListeners();
  }

  Future<bool> filterEpisodes(String value) async {
    if (value.isEmpty) {
      _filteredEpisodes.clear();
      notifyListeners();
      return true;
    }
    final query = queries['getFilteredEpisodes'];
    final args = {"name": value};
    _isLoading = true;
    notifyListeners();
    try {
      final result = await _graphqlService.executeQuery(query, variables: args);
      if (result.hasException) {
        throw result.exception!;
      }

      _filteredEpisodes = (result.data?['episodes']['results'] ?? []).map((episode) {
        int index = int.parse(episode['id']) - 1;
        return {
          ...episode,
          'imagePath': _allEpisodes[index]['imagePath'],
          'isWatched': _allEpisodes[index]['isWatched'],
          'isFavorite': _allEpisodes[index]['isFavorite'],
        };
      }).toList();

      if (_filteredEpisodes.isEmpty) {
        return false;
      }
      return true;
    } catch (_) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleWatchedStatus(int episodeId) async {
    _allEpisodes[episodeId]['isWatched'] = !_allEpisodes[episodeId]['isWatched'];

    if (_filteredEpisodes.isNotEmpty) {
      final index = _filteredEpisodes.indexWhere((episode) => (int.parse(episode['id']) - 1) == episodeId);
      if (index != -1) {
        _filteredEpisodes[index]['isWatched'] = !_filteredEpisodes[index]['isWatched'];
      }
    }

    await HiveManager.setValue(episodeId, [
      _allEpisodes[episodeId]['isFavorite'],
      _allEpisodes[episodeId]['isWatched'],
    ]);

    notifyListeners();
  }

  void toggleFavoriteStatus(int episodeId) async {
    _allEpisodes[episodeId]['isFavorite'] = !_allEpisodes[episodeId]['isFavorite'];
    if (_filteredEpisodes.isNotEmpty) {
      final index = _filteredEpisodes.indexWhere((episode) => (int.parse(episode['id']) - 1) == episodeId);
      if (index != -1) {
        _filteredEpisodes[index]['isFavorite'] = !_filteredEpisodes[index]['isFavorite'];
      }
    }
    if (_allEpisodes[episodeId]['isFavorite']) {
      _favoriteEpisodes.add(_allEpisodes[episodeId]);
    } else {
      _favoriteEpisodes.removeWhere((episode) => (int.parse(episode['id']) - 1) == episodeId);
    }

    await HiveManager.setValue(episodeId, [
      _allEpisodes[episodeId]['isFavorite'],
      _allEpisodes[episodeId]['isWatched'],
    ]);

    notifyListeners();
  }
}
