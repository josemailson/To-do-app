import 'dart:convert';

class ToDoModel {
  final String title;
  final String description;
  final bool isDone;
  final String? id;
  ToDoModel({
    required this.title,
    required this.description,
    required this.isDone,
    this.id,
  });

  ToDoModel copyWith({
    String? title,
    String? description,
    bool? isDone,
  }) {
    return ToDoModel(
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] as bool,
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDoModel.fromJson(String source) =>
      ToDoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ToDoModel(title: $title, description: $description, isDone: $isDone)';

  @override
  bool operator ==(covariant ToDoModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.isDone == isDone;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ isDone.hashCode;
}
