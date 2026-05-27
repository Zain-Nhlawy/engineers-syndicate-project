class EventModel {
  int? id;
  String? eventTitle;
  String? startTimestamp;
  String? endTimestamp;
  String? eventStatus;
  int? maxCapacity;
  int? ticketPrice;
  int? bookingId;

  EventModel(
      {this.id,
      this.eventTitle,
      this.startTimestamp,
      this.endTimestamp,
      this.eventStatus,
      this.maxCapacity,
      this.ticketPrice,
      this.bookingId});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    eventTitle = json['eventTitle'] ?? ' ';
    startTimestamp = json['startTimestamp'] ?? ' ';
    endTimestamp = json['endTimestamp'] ?? ' ';
    eventStatus = json['eventStatus'] ?? ' ';
    maxCapacity = json['maxCapacity'] ?? 0;
    ticketPrice = json['ticketPrice'] ?? 0;
    bookingId = json['bookingId'] ?? 0;
  }


}