class Plant {
  final int? id;
  final String title, country, image;
  final int price;

  Plant(
      {this.id,
      required this.title,
      required this.country,
      required this.image,
      required this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'country': country,
      'image': image,
      'price': price,
    };
  }

  @override
  String toString() {
    return 'Plant{title: $title, country: $country, image: $image, id: $id, price: $price}';
  }
}
