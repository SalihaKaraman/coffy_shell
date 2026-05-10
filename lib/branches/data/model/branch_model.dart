import 'package:coffy_shell/branches/domain/entity/branch.dart';

class BranchModel {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String openingHours;
  final double rating;

  BranchModel({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    required this.openingHours,
    required this.rating,
  });

  factory BranchModel.fromMap(Map<String, dynamic> data, String id) {
    return BranchModel(
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

  Branch toEntity() {
    return Branch(
      id: id,
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      phoneNumber: phoneNumber,
      openingHours: openingHours,
      rating: rating,
    );
  }
}
