import 'dart:convert';

import 'package:distillers_calculator/model/sortable_note.dart';

class ImageNote implements SortableNote {
  String imagePath;
  String description;
  @override
  int id;
  @override
  int batchId;
  @override
  String createdAt;

  ImageNote({
    required this.imagePath,
    required this.description,
    required this.id,
    required this.batchId,
    required this.createdAt,
  });

  ImageNote copyWith({
    String? imagePath,
    String? description,
    int? id,
    int? batchId,
    String? createdAt,
  }) {
    return ImageNote(
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'description': description,
      'id': id,
      'batchId': batchId,
      'createdAt': createdAt,
    };
  }

  factory ImageNote.fromMap(Map<String, dynamic> map) {
    return ImageNote(
      imagePath: map['imagePath'] ?? '',
      description: map['description'] ?? '',
      id: map['id']?.toInt() ?? 0,
      batchId: map['batchId']?.toInt() ?? 0,
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageNote.fromJson(String source) =>
      ImageNote.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ImageNote(imagePath: $imagePath, description: $description, id: $id, batchId: $batchId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageNote &&
        other.imagePath == imagePath &&
        other.description == description &&
        other.id == id &&
        other.batchId == batchId &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return imagePath.hashCode ^
        description.hashCode ^
        id.hashCode ^
        batchId.hashCode ^
        createdAt.hashCode;
  }

  @override
  String shortCreatedDateTime() {
    // TODO: implement shortCreatedDateTime
    throw UnimplementedError();
  }

  @override
  int get createdAtDate {
    var dt = DateTime.parse(createdAt);
    return dt.millisecondsSinceEpoch;
  }
}
