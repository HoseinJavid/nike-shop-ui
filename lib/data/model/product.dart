
class Product {
  final int id;
  final String title;
  final double price;
  final double discount;
  final String imageUrl;
  final int status;
  final double previousPrice;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.discount,
      required this.imageUrl,
      required this.status,
      required this.previousPrice});

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        discount = json['discount'],
        imageUrl = json['image'],
        status = json['status'],
        previousPrice = json['previous_price'];
}
