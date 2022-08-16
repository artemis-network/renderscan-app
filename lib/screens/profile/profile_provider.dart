import 'package:flutter/material.dart';
import 'package:renderscan/screens/profile/profile_api.dart';

class ProfileProvider extends ChangeNotifier {
  Profile _profile =
      Profile(displayName: "...", region: "...", language: "...", email: "...");

  setProfile(Profile profile) {
    _profile = profile;
    notifyListeners();
  }

  setDisplayName(String displayName) {
    Profile profile = Profile(
        displayName: displayName,
        region: _profile.region,
        language: _profile.language,
        email: _profile.email);

    _profile = profile;
    notifyListeners();
  }

  setRegion(String region) {
    Profile profile = Profile(
        displayName: _profile.displayName,
        region: region,
        language: _profile.language,
        email: _profile.email);
    _profile = profile;
    notifyListeners();
  }

  setLanguage(String language) {
    Profile profile = Profile(
        displayName: _profile.displayName,
        region: _profile.region,
        language: language,
        email: _profile.email);

    _profile = profile;
    notifyListeners();
  }

  setEmail(String email) {
    Profile profile = Profile(
        displayName: _profile.displayName,
        region: _profile.region,
        language: _profile.language,
        email: email);
    _profile = profile;
    notifyListeners();
  }

  get profile => _profile;
}
