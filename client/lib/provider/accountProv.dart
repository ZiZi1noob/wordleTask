import 'package:flutter/material.dart';
import 'package:wordle/services/userService.dart' show UserService;

class AccountProvider with ChangeNotifier {
  String? _name;
  bool _isLoading = false;
  bool _isResumeGame = false;
  Map<String, dynamic> _stats = {};

  // Getters
  String? get name => _name;
  bool get isLoading => _isLoading;
  bool get isResumeGame => _isResumeGame;
  Map<String, dynamic> get stats => _stats;

  // Login with async loading and stats
  Future<void> getUserInfo(String name, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      // 1. First call: Get user info
      final userInfo = await UserService().getUserInfo(name);
      print('userInfo:  ${userInfo}');
      // 2. Second call: Get user stats (assuming you have a similar service method)
      final userStats = await _fetchUserStats(
        name,
      ); // This should also be a real API call

      // 3. Update state with real data
      _name = name;
      _isResumeGame = userStats['pending_game'] ?? false;
      _stats = userStats;

      // Optional: You might want to store the user info somewhere
      // _userInfo = userInfo;
    } catch (e) {
      // Convert API errors to user-friendly messages
      final errorMessage =
          e.toString().contains('Login failed')
              ? e.toString()
              : 'Failed to login. Please try again.';
      throw Exception(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Mock stats fetch (replace with real API call)
  Future<Map<String, dynamic>> _fetchUserStats(String name) async {
    return {
      'wins': 12,
      'losses': 3,
      'pending_game': name.contains('resume'), // Example logic
    };
  }

  // Logout
  void logout() {
    _name = null;
    _isResumeGame = false;
    _stats = {};
    notifyListeners();
  }
}
