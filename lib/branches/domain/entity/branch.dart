class Branch {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String openingHours;
  final double rating;

  Branch({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    required this.openingHours,
    this.rating = 4.5,
  });

  factory Branch.fromMap(Map<String, dynamic> data, String id) {
    return Branch(
      id: id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
      phoneNumber: data['phoneNumber'] ?? '',
      openingHours: data['openingHours'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'phoneNumber': phoneNumber,
      'openingHours': openingHours,
      'rating': rating,
    };
  }
}
