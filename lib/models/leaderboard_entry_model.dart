class LeaderboardEntryModel {
  String id;
  String username;
  int totalPoints;

  LeaderboardEntryModel({
    required this.id,
    required this.username,
    required this.totalPoints,
  });

  factory LeaderboardEntryModel.fromMap(String id, Map<String, dynamic> data) {
    return LeaderboardEntryModel(
      id: id,
      username: data['name'] as String,
      totalPoints: data['totalPoints'] as int,
    );
  }
}
