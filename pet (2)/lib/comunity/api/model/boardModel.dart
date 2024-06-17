class boardModel {
  final String id;
  final String title;
  final String content;
  final String? thumbnail;
  final String writer;
  final int likeCount;
  final int commentCount;
  final bool isPetHelp;

  boardModel({
    required this. id,
    required this. title,
    required this. content,
    required this. thumbnail,
    required this. writer,
    required this.likeCount,
    required this.commentCount,
    required this. isPetHelp,
  });


  factory boardModel.fromJson(Map<String, dynamic> json) {
    return boardModel(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      thumbnail: json["thumbnail"],
      writer: json["writer"],
      likeCount: json["likeCount"],
      commentCount: json["commentCount"],
      isPetHelp: json["isPetHelp"],
    );
  }
}