class BuildingModel {
  final int id;
  final String name;
  final String workingHours;
  final String contactNumber;
  final String address;
  final String imagePath;
  final int totalRooms;

  BuildingModel({
    required this.id,
    required this.name,
    required this.workingHours,
    required this.contactNumber,
    required this.address,
    required this.imagePath,
    required this.totalRooms,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    final String open = json['openTime']?.toString() ?? '0';
    final String close = json['closeTime']?.toString() ?? '0';
    
    return BuildingModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      workingHours: '$open:00 → $close:00',
      contactNumber: json['contactNumber']?.toString() ?? '',
      address: json['address'] ?? '',
      imagePath: json['imagePath'] ?? '',
      totalRooms: json['totalRooms'] is int ? json['totalRooms'] : 0,
    );
  }
}