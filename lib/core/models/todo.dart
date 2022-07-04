const todoTable = 'todo';

class TodoFields {
  static final List<String> values = [
    id,
    title,
    duration,
    details,
    date,
    status,
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String duration = 'duration';
  static const String details = 'details';
  static const String date = 'date';
  static const String status = 'status';
}

class TodoModel {
  int? id;
  String title;
  String duration;
  String details;
  DateTime date;
  String status;

  TodoModel({
    this.id,
    required this.details,
    required this.duration,
    required this.title,
    required this.date,
    required this.status,
  });

  TodoModel copy({
    int? id,
    String? title,
    String? duration,
    String? details,
    DateTime? date,
    String? status,
  }) =>
      TodoModel(
        id: id ?? this.id,
        details: details ?? this.details,
        duration: duration ?? this.duration,
        title: title ?? this.title,
        date: date ?? this.date,
        status: status ?? this.status,
      );

  static TodoModel fromJson(Map<String, Object?> json) => TodoModel(
        id: json[TodoFields.id] as int?,
        details: json[TodoFields.details] as String,
        duration: json[TodoFields.duration] as String,
        title: json[TodoFields.title] as String,
        date: DateTime.parse(json[TodoFields.date] as String),
        status: json[TodoFields.status] as String,
      );

  Map<String, Object?> toJson() => {
        TodoFields.id: id,
        TodoFields.title: title,
        TodoFields.duration: duration,
        TodoFields.details: details,
        TodoFields.date: date.toIso8601String(),
        TodoFields.status: status,
      };
}
