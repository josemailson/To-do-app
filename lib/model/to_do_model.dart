import 'dart:convert';

class ToDoModel {
  final String title;
  final String description;
  final bool isDone;
  final String? id;
  final DateTime date;
  final String userId;
  ToDoModel({
    required this.title,
    required this.description,
    required this.isDone,
    this.id,
    required this.date,
    required this.userId,
  });

  ToDoModel copyWith({
    String? title,
    String? description,
    bool? isDone,
    String? id,
    DateTime? date,
    String? userId,
  }) {
    return ToDoModel(
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      id: id ?? this.id,
      date: date ?? this.date,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'isDone': isDone,
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'userId': userId,
    };
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] as bool,
      id: map['id'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDoModel.fromJson(String source) =>
      ToDoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ToDoModel(title: $title, description: $description, isDone: $isDone, id: $id, date: $date, userId: $userId)';
  }

  @override
  bool operator ==(covariant ToDoModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.isDone == isDone &&
        other.id == id &&
        other.date == date &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        isDone.hashCode ^
        id.hashCode ^
        date.hashCode ^
        userId.hashCode;
  }
}
