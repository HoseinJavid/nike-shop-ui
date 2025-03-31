class Banner {
  final int id;
  final String imageUrl;
  final String link_type;
  final String link_value;

  Banner(
      {required this.id,
      required this.imageUrl,
      required this.link_type,
      required this.link_value});

  Banner.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        imageUrl = json['image'],
        link_type = json['link_type'],
        link_value = json['link_value'];
}
