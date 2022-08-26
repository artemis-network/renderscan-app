import 'package:flutter/material.dart';
import 'package:renderscan/screens/explore/search_api.dart';
import 'package:renderscan/screens/home/home_screen_api.dart';
import 'package:renderscan/screens/home/models/nfts.model.dart';
import 'package:renderscan/screens/home/models/notable_collection.model.dart';
import 'package:renderscan/screens/home/models/trending_model.dart';
import 'package:renderscan/screens/ranking/ranking_api.dart';

class HomeProvider extends ChangeNotifier {
  List<TrendingModel> _trending = [];
  bool _isTrendingLoaded = false;

  List<TrendingModel> _rankingSortByTime = [];
  bool _isrankingSortByTimeLoaded = false;
  String _currentTrendingrankingSortByTime = "daily";

  List<NFTHomeModel> _showcase = [];
  bool _isShowcaseLoaded = false;

  List<NotableCollectionModel> _collections = [];
  bool _isCollectionsLoaded = false;

  List<NFTHomeModel> _solonaNFTs = [];
  bool _isSolanaNFTsLoaded = false;

  List<NFTHomeModel> _exploreNFTs = [];
  bool _exploreNFTSearchDone = false;

  List<NotableCollectionModel> _exploreCollections = [];
  bool _exploreCollectionSearchDone = false;

  initializeHomePage() async {
    _trending = await HomeScreenApi().getTrendingCollections();
    if (_trending.isNotEmpty) {
      _isTrendingLoaded = true;
      _rankingSortByTime = _trending;
      notifyListeners();
      if (_rankingSortByTime.isNotEmpty) {
        _isrankingSortByTimeLoaded = true;
      }
    }
    _showcase = await HomeScreenApi().showCaseNFTs();
    if (_showcase.isNotEmpty) {
      _isShowcaseLoaded = true;
      _exploreNFTs = showcase;
      notifyListeners();
      if (_exploreNFTs.isNotEmpty) {
        _exploreNFTSearchDone = true;
      }
    }

    _collections = await HomeScreenApi().getNotableCollections();
    if (_collections.isNotEmpty) {
      _isCollectionsLoaded = true;
      _exploreCollections = collections;
      notifyListeners();
      if (_exploreCollections.isNotEmpty) {
        _exploreCollectionSearchDone = true;
      }
    }
    _solonaNFTs = await HomeScreenApi().showCaseNFTs("solana");
    if (_solonaNFTs.isNotEmpty) {
      _isSolanaNFTsLoaded = true;
    }
    notifyListeners();
  }

  exploreSearchNFTs(String search) async {
    _exploreNFTSearchDone = false;
    _exploreNFTs = await SearchAPI().searchNFts(search);
    if (_exploreNFTs.isNotEmpty) {
      _exploreNFTSearchDone = true;
    }
    notifyListeners();
  }

  exploreClearSearchNFTs() async {
    _exploreNFTSearchDone = false;
    _exploreNFTs = await _showcase;
    if (_exploreNFTs.isNotEmpty) {
      _exploreNFTSearchDone = true;
    }
    notifyListeners();
  }

  exploreSearchCollection(String search) async {
    _exploreCollectionSearchDone = false;
    _exploreCollections = await SearchAPI().searchCollections(search);
    if (_exploreCollections.isNotEmpty) {
      _exploreCollectionSearchDone = true;
    }
    notifyListeners();
  }

  exploreClearSearchCollections() async {
    _exploreCollectionSearchDone = false;
    _exploreCollections = await _collections;
    if (_exploreCollections.isNotEmpty) {
      _exploreCollectionSearchDone = true;
    }
    notifyListeners();
  }

  rankingSortByTimeFun(String sort) {
    _isrankingSortByTimeLoaded = false;
    _currentTrendingrankingSortByTime = sort;
    if (sort == "daily") {
      _rankingSortByTime.sort((a, b) {
        final double x = double.parse(a.oneDayChange);
        final double y = double.parse(b.oneDayChange);
        return x.compareTo(y);
      });
      _rankingSortByTime.reversed;
    }
    if (sort == "weekly") {
      _rankingSortByTime.sort((a, b) {
        final double x = double.parse(a.sevenDayChange);
        final double y = double.parse(b.sevenDayChange);
        return x.compareTo(y);
      });
      _rankingSortByTime.reversed;
    }
    if (sort == "monthly") {
      _rankingSortByTime.sort((a, b) {
        final double x = double.parse(a.thirtyDayChange);
        final double y = double.parse(b.thirtyDayChange);
        return x.compareTo(y);
      });
      _rankingSortByTime.reversed;
    }
    _isrankingSortByTimeLoaded = true;
    notifyListeners();
  }

  filterByCategory(String filter) async {
    _isrankingSortByTimeLoaded = false;
    _rankingSortByTime =
        await RankingScreenApi().getTrendingCollectionsByCategoryFilter(filter);
    if (_rankingSortByTime.isNotEmpty) {
      _isrankingSortByTimeLoaded = true;
    }
    notifyListeners();
  }

  get trending => _trending;
  get trendingLoaded => _isTrendingLoaded;
  get sortByTrending async => await _rankingSortByTime;
  get sortByTrendingLoaded => _isrankingSortByTimeLoaded;
  get currentTrendingrankingSortByTime => _currentTrendingrankingSortByTime;

  get showcase => _showcase;
  get showcaseLoaded => _isShowcaseLoaded;

  get collections => _collections;
  get collectionsLoaded => _isCollectionsLoaded;

  get solanaNFts => _solonaNFTs;
  get solanaNFTsLoaded => _isSolanaNFTsLoaded;

  get exploreNFTs async => await _exploreNFTs;
  get exploreNFTSearchDone => _exploreNFTSearchDone;

  get exploreCollections async => await _exploreCollections;
  get exploreCollectionSearchDone => _exploreCollectionSearchDone;
}
