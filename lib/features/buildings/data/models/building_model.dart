
class BuildingModel {
  final int id;
  final String name;
  final String workingHours;
  final String contactNumber;
  final String locationDetails;
  final String googleMapsUrl;
  final int totalRooms;
  final String imageUrl;

  BuildingModel({
    required this.id,
    required this.name,
    required this.workingHours,
    required this.contactNumber,
    required this.locationDetails,
    required this.googleMapsUrl,
    required this.totalRooms,
    required this.imageUrl,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      workingHours: json['workingHours'] ?? '9:00 → 5:00',
      contactNumber: json['contactNumber'] ?? '',
      locationDetails: json['locationDetails'] ?? '',
      googleMapsUrl: json['googleMapsUrl'] ?? '',
      totalRooms: json['totalRooms'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}