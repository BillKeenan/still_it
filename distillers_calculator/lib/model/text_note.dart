import 'dart:convert';

import 'package:distillers_calculator/model/sortable_note.dart';

class TextNote implements SortableNote {
  String note;
  @override
  int id;
  @override
  String createdAt;

  @override
  int batchId;

  TextNote({
    required this.note,
    required this.id,
    required this.createdAt,
    required this.batchId,
  });

  TextNote copyWith({
    String? note,
    int? id,
    String? createdAt,
    int? batchId,
  }) {
    return TextNote(
      note: note ?? this.note,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      batchId: batchId ?? this.batchId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'id': id,
      'createdAt': createdAt,
      'batchId': batchId,
    };
  }

  factory TextNote.fromMap(Map<String, dynamic> map) {
    return TextNote(
      note: map['note'] ?? '',
      id: map['id']?.toInt() ?? 0,
      createdAt: map['createdAt'] ?? '',
      batchId: map['batchId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TextNote.fromJson(String source) =>
      TextNote.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TextNote(note: $note, id: $id, createdAt: $createdAt, batchId: $batchId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TextNote &&
        other.note == note &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.batchId == batchId;
  }

  @override
  int get hashCode {
    return note.hashCode ^ id.hashCode ^ createdAt.hashCode ^ batchId.hashCode;
  }

  @override
  DateTime get createdAtDate {
    var dt = DateTime.parse(createdAt);
    return dt;
  }
}
