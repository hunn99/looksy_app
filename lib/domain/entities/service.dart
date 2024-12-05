class Item {
  final int id;
  final String name;
  final int price;

  Item({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Item.fromServiceJson(Map<String, dynamic> json) {
    final service = json['service'] ?? {};
    return Item(
      id: service['id'] ?? 0,
      name: service['name'] ?? '',
      price: service['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}
