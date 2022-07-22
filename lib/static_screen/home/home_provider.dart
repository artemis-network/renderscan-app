import 'package:flutter/material.dart';
import 'package:renderscan/static_screen/home/home_screen_api.dart';
import 'package:renderscan/static_screen/home/models/notable_collection.model.dart';
import 'package:renderscan/static_screen/home/models/trending_model.dart';
import 'package:renderscan/static_screen/nfts_collection/models/nft.model.dart';

class HomeProvider extends ChangeNotifier {
  List<NFTModel> _showcase = [];
  List<NFTModel> _solonaNFTs = [];
  List<TrendingModel> _trending = [];
  List<NotableCollectionModel> _collections = [];

  bool _isTrendingLoaded = false;
  bool _isShowcaseLoaded = false;
  bool _isCollectionsLoaded = false;
  bool _isSolanaNFTsLoaded = false;

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
    _solonaNFTs = await HomeScreenApi().showCaseNFTs("solana");
    if (_solonaNFTs.isNotEmpty) {
      _isSolanaNFTsLoaded = true;
    }
    notifyListeners();
  }

  get trending => _trending;
  get trendingLoaded => _isTrendingLoaded;

  get showcase => _showcase;
  get showcaseLoaded => _isShowcaseLoaded;

  get collections => _collections;
  get collectionsLoaded => _isCollectionsLoaded;

  get solanaNFts => _solonaNFTs;
  get solanaNFTsLoaded => _isSolanaNFTsLoaded;
}
