

class EventsModel {
  final int? id;
  final String eventName;
  final String address;

  EventsModel({
    this.id,
    required this.eventName,
    required this.address,
  });

  EventsModel.fromMap(Map<dynamic, dynamic> res)
      : id = res["id"],
        eventName = res["eventName"],
        address = res["address"];

  Map<String, Object?> toMap() {
    return {'id':id, 'eventName': eventName, 'address': address};
  }
}


