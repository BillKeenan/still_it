import 'dart:convert';

class Batch {
  String name;
  int id;
  String batchStartedDate;
  String createdAt;

  Batch({
    required this.name,
    required this.id,
    required this.batchStartedDate,
    required this.createdAt,
  });

  DateTime get batchStartedDateAsDate => DateTime.parse(batchStartedDate);

  Batch copyWith({
    String? name,
    int? id,
    String? batchStartedDate,
    String? createdAt,
  }) {
    return Batch(
      name: name ?? this.name,
      id: id ?? this.id,
      batchStartedDate: batchStartedDate ?? this.batchStartedDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'batchStartedDate': batchStartedDate,
      'createdAt': createdAt,
    };
  }

  factory Batch.fromMap(Map<String, dynamic> map) {
    return Batch(
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
      batchStartedDate: map['batchStartedDate'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Batch.fromJson(String source) => Batch.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Batch(name: $name, id: $id, batchStartedDate: $batchStartedDate, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Batch &&
        other.name == name &&
        other.id == id &&
        other.batchStartedDate == batchStartedDate &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        batchStartedDate.hashCode ^
        createdAt.hashCode;
  }

  DateTime get createdAtDate {
    var dt = DateTime.parse(createdAt);
    return dt;
  }
}
