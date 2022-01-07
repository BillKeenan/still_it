import 'dart:convert';

class Note {
  String? note;
  int? id;
  int? batch;

  Note({
    required this.note,
    required this.id,
    required this.batch,
  });

  Note copyWith({
    String? note,
    int? id,
    int? batch,
  }) {
    return Note(
      note: note ?? this.note,
      id: id ?? this.id,
      batch: batch ?? this.batch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'id': id,
      'batch': batch,
    };
  }

  Note.fromMap(Map<dynamic, dynamic> map) {
    id = map['id']?.toInt();
    note = map["note"].toString();
    batch = int.parse(map["batch"].toString());
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() => 'Note(note: $note, id: $id, batch: $batch)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.note == note &&
        other.id == id &&
        other.batch == batch;
  }

  @override
  int get hashCode => note.hashCode ^ id.hashCode ^ batch.hashCode;
}
