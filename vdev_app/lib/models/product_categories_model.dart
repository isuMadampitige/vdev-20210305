class Product {
  final int id;
  final String name;
  final String description;
  final bool status;

  Product({this.id, this.description, this.name, this.status});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
    );
  }
}
