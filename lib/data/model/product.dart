class Product {
  final int id;
  final String title;
  final int price;
  final int discount;
  final String image;
  final int status;
  final int previousPrice;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.discount,
    required this.image,
    required this.status,
    required this.previousPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'discount': discount,
      'image': image,
      'status': status,
      'previous_price': previousPrice,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'] as int,
      discount: json['discount'] as int,
      image: json['image'] as String,
      status: json['status'] as int,
      previousPrice: json['previous_price'] as int,
    );
  }
}
