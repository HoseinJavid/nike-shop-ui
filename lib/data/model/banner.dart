class Banner {
  final int id;
  final String image;
  final String linkType;
  final String linkValue;

  Banner({
    required this.id,
    required this.image,
    required this.linkType,
    required this.linkValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'link_type': linkType,
      'link_value': linkValue,
    };
  }

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      image: json['image'],
      linkType: json['link_type'],
      linkValue: json['link_value'],
    );
  }
}
