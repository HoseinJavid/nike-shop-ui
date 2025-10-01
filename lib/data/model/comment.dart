class Comment {
  final int id;
  final String title;
  final String content;
  final String date;
  final String authorEmail;

  Comment({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.authorEmail,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
      authorEmail: json['author_email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
      'author_email': authorEmail,
    };
  }
}
