import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier{

  UserProfile _userProfile = UserProfile();

  UserProfile get userProfile => _userProfile;

  void updateUserProfile(UserProfile newUserProfile) {
    _userProfile = newUserProfile;
    notifyListeners();
  }
}

class UserProfile {
  String userName;
  String email;
  String phoneNumber;
  String country;
  String currentLocation;
  String bio;

  UserProfile({
    this.userName = "",
    this.email = "",
    this.phoneNumber = "",
    this.country = "",
    this.currentLocation = "",
    this.bio = "",
  });
}