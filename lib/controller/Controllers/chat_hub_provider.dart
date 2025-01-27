import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tactix_academy_players/model/TeamDatabase/chat_hub_database.dart';
import 'package:tactix_academy_players/model/TeamDatabase/team_database.dart';
import 'package:tactix_academy_players/model/UserDatabse/player_db.dart';
import 'package:tactix_academy_players/model/chat_model.dart';
import 'package:tactix_academy_players/model/manager_model.dart';
import 'package:tactix_academy_players/model/playermodel.dart';

class ChatHubProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ManagerModel? _manager;
  ManagerModel? get manager => _manager; // Allow nullable return

  List<PlayerModel> _allPlayers = [];
  List<PlayerModel> get allPlayers => _allPlayers;

  /// Fetch all players from the database
  Future<void> fetchAllPlayers() async {
    _isLoading = true;
    notifyListeners();
    try {
      final userID = FirebaseAuth.instance.currentUser!.uid;
      _allPlayers.clear();
      final players = await PlayerDataBase().fetchTeamPlayers();
      for (var player in players) {
        if (player.id != userID) {
          _allPlayers.add(player);
        }
      }
    } catch (e) {
      log("Error fetching players: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Fetch manager details from the database
  Future<void> fetchManager() async {
    _isLoading = true;
    notifyListeners();
    try {
      _manager = await TeamDatabase().fetchTeamManager();
      notifyListeners();
    } catch (e) {
      log("Error fetching manager: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createChatRoom(String playerId) async {
    await ChatHubDatabase().createChatRoom(playerId);
  }

  Stream<List<ChatModel>> getMessages(String playerId) {
    return ChatHubDatabase().getMessages(playerId).map((snapshot) {
      return snapshot.map((messageData) {
        return ChatModel(
          message: messageData['message'],
          sender: messageData['sender'],
          time: (messageData['timeStamp'] as Timestamp?)?.toDate().toString() ??
              DateTime.now().toString(),
        );
      }).toList();
    });
  }

  Future<void> sendMessage(String message, String playerId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await ChatHubDatabase().sendMessage(message, userId, playerId);
    }
  }
}
