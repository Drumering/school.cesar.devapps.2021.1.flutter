class Plant {
  final int? id;
  final String title, country, image;
  final int price;
  bool isFavorite;

  Plant({
    this.id,
    this.isFavorite = false,
    required this.title,
    required this.country,
    required this.image,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'country': country,
      'image': image,
      'price': price,
      'isFavorite': isFavorite,
    };
  }

  @override
  String toString() {
    return 'Plant{id: $id, title: $title, country: $country, image: $image, price: $price, isFavorite: $isFavorite}';
  }
}
