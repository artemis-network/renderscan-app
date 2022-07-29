import 'package:flutter/material.dart';
import 'package:renderscan/static_screen/profile/profile_api.dart';

class ProfileProvider extends ChangeNotifier {
  Profile _profile =
      Profile(displayName: "...", region: "...", language: "...");

  setProfile(Profile profile) {
    _profile = profile;
    notifyListeners();
  }

  setDisplayName(String displayName) {
    Profile profile = Profile(
        displayName: displayName,
        region: _profile.region,
        language: _profile.language);
    _profile = profile;
    notifyListeners();
  }

  setRegion(String region) {
    Profile profile = Profile(
        displayName: _profile.displayName,
        region: region,
        language: _profile.language);
    _profile = profile;
    notifyListeners();
  }

  setLanguage(String language) {
    Profile profile = Profile(
        displayName: _profile.displayName,
        region: _profile.region,
        language: language);
    _profile = profile;
    notifyListeners();
  }

  get profile => _profile;
}
