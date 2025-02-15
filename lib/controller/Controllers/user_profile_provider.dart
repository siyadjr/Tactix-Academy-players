import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tactix_academy_players/core/Important/shared_preference.dart';
import 'package:tactix_academy_players/model/Api/cloudinery_class.dart';
import 'package:tactix_academy_players/model/TeamDatabase/team_database.dart';
import 'package:tactix_academy_players/model/UserDatabse/player_db.dart';
import 'package:tactix_academy_players/model/UserDatabse/user_database.dart';
import 'package:tactix_academy_players/model/playermodel.dart';
import 'package:tactix_academy_players/view/Authentications/SignIn/sign_in.dart';

class UserProfileProvider extends ChangeNotifier {
  PlayerModel? _player;
  PlayerModel? get player => _player;
  bool _imageLoading = false;
  bool get imageLoading => _imageLoading;
  bool _nameLoading = false;
  bool get nameLoading => _nameLoading;
  String? _imagePath;
  String? _name;
  String? get name => _name;
  String? get imagepath => _imagePath;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> getUserData() async {
    _isLoading = true;
    notifyListeners();
    _player = await PlayerDataBase().getUser();
    _imagePath = _player!.userProfile;
    _name = _player!.name;
    _isLoading = false;

    notifyListeners();
  }

  Future<void> logout(context) async {
    await SharedPreferenceDatas().logout();
  
  }

  Future<void> deleteAccount(context) async {
    _isLoading = true;
    notifyListeners();
    await UserDatabase().deleteAccount();
    await SharedPreferenceDatas().logout();
  
  }

  Future<void> updateImageUi(String image) async {
    _imageLoading = true;
    notifyListeners();
    final cloudineryImage = await CloudineryClass().uploadProfile(image);
    if (cloudineryImage != null) {
      _imagePath = cloudineryImage;

      await UserDatabase().uploadUserProfile(cloudineryImage);
    }
    _imageLoading = false;
    notifyListeners();
  }

  Future<void> updateUserName(String newName) async {
    _nameLoading = true;
    notifyListeners();
    await UserDatabase().updateUserName(newName);
    _name = newName;
    _nameLoading = false;
    notifyListeners();
  }
}
