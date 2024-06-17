class detailModel {
  final String id;
  final String title;
  final String content;
  final List<dynamic> images;
  final String writer;
  final int likeCount;
  final int commentCount;
  final bool isPetHelp;
  final String createdAt;
  final bool isLiked;

  detailModel({
    required this. id,
    required this. title,
    required this. content,
    required this. images,
    required this. writer,
    required this.likeCount,
    required this.commentCount,
    required this. isPetHelp,
    required this. createdAt,
    required this. isLiked,
  });


  factory detailModel.fromJson(Map<String, dynamic> json) {
    return detailModel(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      images: json["images"],
      writer: json["writer"],
      likeCount: json["likeCount"],
      commentCount: json["commentCount"],
      isPetHelp: json["isPetHelp"],
      createdAt: json["createdAt"],
      isLiked: json["isLiked"],
    );
  }
}