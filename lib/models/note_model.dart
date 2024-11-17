
class NoteModel {
  final int id;
  final String title;
  final String content;
  final DateTime dateCreated;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    DateTime? dateCreated,
  }) : dateCreated = dateCreated ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'dateCreated': dateCreated.toIso8601String(),
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
    );
  }
}