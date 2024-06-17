class boardModel {
  final String id;
  final String writer;
  final String content;
  final String createdAt;

  boardModel({
    required this. id,
    required this. writer,
    required this. content,
    required this. createdAt,
  });


  factory boardModel.fromJson(Map<String, dynamic> json) {
    return boardModel(
      id: json["id"],
      writer: json["writer"],
      content: json["content"],
      createdAt: json["createdAt"],
    );
  }
}