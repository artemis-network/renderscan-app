import 'package:flutter/material.dart';
import 'package:renderscan/screen/home/home_screen_api.dart';
import 'package:renderscan/screen/home/models/trending_model.dart';

class HomeProvider extends ChangeNotifier {
  List<ShowCaseDTO> _showcase = [];
  List<TrendingDTO> _trending = [];
  List<NotableCollection> _collections = [];
  bool _isShowcaseLoaded = false;
  bool _isTrendingLoaded = false;
  bool _isCollectionsLoaded = false;

  initializeHomePage() async {
    _trending = await HomeScreenApi().getTrendingCollections();
    if (_trending.isNotEmpty) {
      _isTrendingLoaded = true;
    }
    _showcase = await HomeScreenApi().showCaseNFTs();
    if (_showcase.isNotEmpty) {
      _isShowcaseLoaded = true;
    }
    _collections = await HomeScreenApi().getNotableCollections();
    if (_collections.isNotEmpty) {
      _isCollectionsLoaded = true;
    }
    notifyListeners();
  }

  get trending => _trending;
  get trendingLoaded => _isTrendingLoaded;

  get showcase => _showcase;
  get showcaseLoaded => _isShowcaseLoaded;

  get collections => _collections;
  get collectionsLoaded => _isCollectionsLoaded;
}
