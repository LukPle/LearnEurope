class LeaderboardEntryModel {
  String username;
  int totalPoints;

  LeaderboardEntryModel({
    required this.username,
    required this.totalPoints,
  });

  factory LeaderboardEntryModel.fromMap(Map<String, dynamic> data) {
    return LeaderboardEntryModel(
      username: data['name'] as String,
      totalPoints: data['totalPoints'] as int,
    );
  }
}
