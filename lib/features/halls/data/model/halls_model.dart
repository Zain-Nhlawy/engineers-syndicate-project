class HallsModel {
  final int id;
  final String roomNumber;
  final int capacityLimit;
  final int pricePerHour; 
  final String status;
  final String roomType;
  final int buildingId;
  final List<String> images;

  HallsModel({
    required this.id,
    required this.roomNumber,
    required this.capacityLimit,
    required this.pricePerHour,
    required this.status,
    required this.roomType,
    required this.buildingId,
    required this.images,
  });

  factory HallsModel.fromJson(Map<String, dynamic> json) {
    return HallsModel(
      id: json['id'] ?? 0,
      roomNumber: (json['roomNumber'] ?? '').toString(),
      capacityLimit: json['capacityLimit'] ?? 0,
      pricePerHour: (json['pricePerHour'] ?? 0).toInt(),
      status: json['status'] ?? '',
      roomType: json['roomType'] ?? '',
      buildingId: json['buildingId'] ?? 0,
      images: json['images'] != null 
          ? List<String>.from(json['images']) 
          : [],
    );
  }
}