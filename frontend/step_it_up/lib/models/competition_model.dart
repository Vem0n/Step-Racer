class CompetitionCard {
  late final String? user1pic;
  late final String? user2pic;
  late final String user1;
  late final String user2;
  late DateTime timer;
  late int score1;
  late int score2;

  CompetitionCard(
      {required this.user1,
      required this.user2,
      required this.timer,
      required this.score1,
      required this.score2,
      this.user1pic,
      this.user2pic});
}
