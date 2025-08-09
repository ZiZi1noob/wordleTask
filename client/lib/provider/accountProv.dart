import 'package:flutter/material.dart';
import 'package:wordle/models/userModel.dart';
import 'package:wordle/services/userService.dart' show UserService;

class AccountProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;

  // Getters
  String? get name => _user?.user.username;
  bool get isLoading => _isLoading;
  bool get isResumeGame => _user?.gameHistory.pending != null;
  UserStats? get stats => _user?.stats;
  UserModel? get userData => _user;

  Future<void> getUserInfo(String name, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await UserService().getUserInfo(name);

      if (response.isSuccess && response.data != null) {
        _user = response.data!;
        print('User state updated: $_user');
      } else {
        throw response.message ?? 'Failed to get user info';
      }
    } catch (e, stackTrace) {
      print('Error fetching user info: $e\n$stackTrace');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
    print('User logged out');
  }

  // Helper methods
  double get winPercentage => _user?.stats.winPercentage ?? 0.0;
  List<int> get guessDistribution =>
      _user?.stats.guessDistribution ?? [0, 0, 0, 0, 0, 0];

  bool hasPendingGame() {
    return _user?.gameHistory.pending != null;
  }

  // GameRecord? get pendingGame {
  //   final pending = _user?.gameHistory.pending;
  //   return pending is GameRecord ? pending : null;
  // }
}
