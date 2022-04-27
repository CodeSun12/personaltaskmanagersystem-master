

class TasksModel {
  final int? id;
  final String taskName;
  final String address;
  final String description;

  TasksModel({
    this.id,
    required this.taskName,
    required this.address,
    required this.description,
  });

  TasksModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        taskName = res["taskName"],
         address = res["address"],
         description = res["description"];

  Map<String, Object?> toMap() {
    return {'id':id, 'taskName': taskName, 'address': address, 'description': description};
  }
}


