const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, description,
  ];

  static final String id = '_id';
  static final String description = 'description';
}

class Note {
  final int? id;
  final String description;

  const Note({
    this.id,
    required this.description,
  });

  Note copy({
    int? id,
    String? description,
  }) =>
      Note(
        id: id ?? this.id,
        description: description ?? this.description,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        description: json[NoteFields.description] as String,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.description: description,
      };
}
