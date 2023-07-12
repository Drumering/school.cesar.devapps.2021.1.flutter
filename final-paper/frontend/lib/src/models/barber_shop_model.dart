class BarberShop {
  BarberShop({
    required this.name,
    required this.profileImage,
    this.favorite,
  });

  String name;
  String profileImage;
  bool? favorite;

  factory BarberShop.fromJson(Map<String, dynamic> json) {
    return BarberShop(
      name: json['name'],
      profileImage: json['profile_image'],
      favorite: json['favorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profile_image': profileImage,
      'favorite': favorite,
    };
  }
}
