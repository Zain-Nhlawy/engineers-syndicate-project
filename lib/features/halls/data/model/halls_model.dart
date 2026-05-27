class HallsModel {
  int? id;
  String? roomNumber;
  int? capacityLimit;
  int? pricePerHour;
  String? status;
  String? roomType;
  int? buildingId;
  List<String>? images;

  HallsModel  ({
    this.id,
    this.roomNumber,
    this.capacityLimit,
    this.pricePerHour,
    this.status,
    this.roomType,
    this.buildingId,
    this.images,
  });

  HallsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    roomNumber = json['roomNumber'] ?? ' ';
    capacityLimit = json['capacityLimit'] ?? 0;
    pricePerHour = json['pricePerHour'] ?? 0;
    status = json['status'] ?? ' ';
    roomType = json['roomType'] ?? ' ';
    buildingId = json['buildingId'] ?? 0;
    if (json['images'] != null) {
      images = <String>[];
      json['images'].forEach((v) {
        images!.add(v);
      });
    }
  }
}
