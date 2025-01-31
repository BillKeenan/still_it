import 'dart:convert';

import 'package:distillers_calculator/model/sortable_note.dart';
import 'package:distillers_calculator/model/specific_gravity.dart';

class SpecificGravityNote implements SortableNote {
  @override
  int batchId;

  SpecificGravity sg;
  @override
  String createdAt;

  @override
  int id;
  SpecificGravityNote({
    required this.batchId,
    required this.sg,
    required this.createdAt,
    required this.id,
  });

  @override
  DateTime get createdAtDate {
    var dt = DateTime.parse(createdAt);
    return dt;
  }

  SpecificGravityNote copyWith({
    int? batchId,
    SpecificGravity? sg,
    String? createdAt,
    int? id,
  }) {
    return SpecificGravityNote(
      batchId: batchId ?? this.batchId,
      sg: sg ?? this.sg,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'batchId': batchId,
      'sg': sg,
      'createdAt': createdAt,
      'id': id,
    };
  }

  factory SpecificGravityNote.fromMap(Map<String, dynamic> map) {
    return SpecificGravityNote(
      batchId: map['batchId']?.toInt() ?? 0,
      sg: SpecificGravity(map['sg'] ?? 0),
      createdAt: map['createdAt'] ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecificGravityNote.fromJson(String source) =>
      SpecificGravityNote.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SpecificGravityNote(batchId: $batchId, sg: $sg, createdAt: $createdAt, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SpecificGravityNote &&
        other.batchId == batchId &&
        other.sg == sg &&
        other.createdAt == createdAt &&
        other.id == id;
  }

  @override
  int get hashCode {
    return batchId.hashCode ^ sg.hashCode ^ createdAt.hashCode ^ id.hashCode;
  }
}
