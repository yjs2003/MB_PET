class CommentModel {
  final String id;
  final String writer;
  final String content;
  final bool isMine;
  final String createdAt;

  CommentModel({
    required this. id,
    required this. writer,
    required this. content,
    required this. isMine,
    required this. createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      writer: json["writer"],
      content: json["content"],
      isMine: json["isMine"],
      createdAt: json["createdAt"],
    );
  }
}