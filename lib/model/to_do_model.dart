class ToDoModel {
  final String? id;
  final String title;
  final String description;
  final DateTime date;
  final String userId;
  final bool isDone;

  ToDoModel(
      {this.id,
      required this.title,
      this.description = '',
      required this.date,
      required this.userId,
      required this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'userId': userId,
      'isDone': isDone
    };
  }

  factory ToDoModel.fromMap(String id, Map<String, dynamic> map) {
    return ToDoModel(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      userId: map['userId'] as String,
      isDone: map['isDone'] as bool,
    );
  }
}
