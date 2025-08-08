import 'package:flutter/material.dart';

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
  Future<void> login(String name) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call (replace with actual backend logic)
      await Future.delayed(const Duration(seconds: 1));

      // Mock response - replace with real data fetching
      final mockStats = await _fetchUserStats(name);
      final bool hasResumeGame = mockStats['pending_game'] ?? false;

      // Update state
      _name = name;
      _isResumeGame = hasResumeGame;
      _stats = mockStats;
    } catch (e) {
      // Handle errors (e.g., show snackbar)
      rethrow;
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
