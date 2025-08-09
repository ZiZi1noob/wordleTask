class UserModel {
  final UserMeta meta;
  final UserInfo user;
  final UserStats stats;
  final GameHistory gameHistory;

  UserModel({
    required this.meta,
    required this.user,
    required this.stats,
    required this.gameHistory,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      meta: UserMeta.fromJson(json['meta']),
      user: UserInfo.fromJson(json['user']),
      stats: UserStats.fromJson(json['stats']),
      gameHistory: GameHistory.fromJson(json['gameHistory']),
    );
  }
  @override
  String toString() {
    return 'UserModel{meta: $meta, user: $user, stats: $stats, gameHistory: $gameHistory}';
  }
}

class UserMeta {
  final String version;
  final DateTime createdAt;
  final DateTime lastUpdated;

  UserMeta({
    required this.version,
    required this.createdAt,
    required this.lastUpdated,
  });

  factory UserMeta.fromJson(Map<String, dynamic> json) {
    return UserMeta(
      version: json['version'],
      createdAt: DateTime.parse(json['createdAt']),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }
  @override
  String toString() {
    return 'UserMeta{version: $version, createdAt: $createdAt, lastUpdated: $lastUpdated}';
  }
}

class UserInfo {
  final String id;
  final String username;
  final Map<String, dynamic> preferences;

  UserInfo({
    required this.id,
    required this.username,
    required this.preferences,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      username: json['username'],
      preferences: json['preferences'] ?? {},
    );
  }
}

class UserStats {
  final int gamesPlayed;
  final int gamesWon;
  final double winPercentage;
  final int currentStreak;
  final int maxStreak;
  final List<int> guessDistribution;
  final double averageTime;

  UserStats({
    required this.gamesPlayed,
    required this.gamesWon,
    required this.winPercentage,
    required this.currentStreak,
    required this.maxStreak,
    required this.guessDistribution,
    required this.averageTime,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      gamesPlayed: json['gamesPlayed'],
      gamesWon: json['gamesWon'],
      winPercentage: json['winPercentage'].toDouble(),
      currentStreak: json['currentStreak'],
      maxStreak: json['maxStreak'],
      guessDistribution: List<int>.from(json['guessDistribution']),
      averageTime: json['averageTime'].toDouble(),
    );
  }
}

class GameHistory {
  final List<dynamic> completed; // List<GameRecord>
  final dynamic pending; // GameRecord?

  GameHistory({required this.completed, this.pending});

  factory GameHistory.fromJson(Map<String, dynamic> json) {
    return GameHistory(
      completed: json['completed'] ?? [],
      pending: json['pending'],
    );
  }
}
