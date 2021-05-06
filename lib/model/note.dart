final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [id, emailId, title, description, time];

  static final String emailId = 'emailId';
  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Note {
  final int? id;
  final String? emailId;
  final String title;
  final String description;
  final DateTime createdTime;

  const Note({
    this.id,
    this.emailId,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Note copy({
    int? id,
    String? emailId,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        emailId: emailId ?? this.emailId,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        title: json[NoteFields.title] as String,
        emailId: json[NoteFields.emailId] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.emailId: emailId,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
      };
}
