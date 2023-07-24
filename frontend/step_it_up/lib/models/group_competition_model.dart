class GroupCompetitionCard {
  late final String? user1pic;
  late final String? user2pic;
  late final String? user3pic;
  late final String? user4pic;
  late final String? user5pic;
  late final String? user6pic;
  late final String user1;
  late final String user2;
  late final String? user3;
  late final String? user4;
  late final String? user5;
  late final String? user6;
  late DateTime timer;
  late int score1;
  late int score2;
  late int? score3;
  late int? score4;
  late int? score5;
  late int? score6;

  GroupCompetitionCard(
      {required this.user1,
      required this.user2,
      this.user3,
      this.user4,
      this.user5,
      this.user6,
      required this.timer,
      required this.score1,
      required this.score2,
      this.score3,
      this.score4,
      this.score5,
      this.score6,
      this.user1pic,
      this.user2pic,
      this.user3pic,
      this.user4pic,
      this.user5pic,
      this.user6pic});
}
