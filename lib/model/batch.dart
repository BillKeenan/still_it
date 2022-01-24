import 'dart:convert';

class Batch {
  String name;
  int id;
  String createdAt;

  Batch({
    required this.name,
    required this.id,
    required this.createdAt,
  });

  Batch copyWith({
    String? name,
    int? id,
    String? createdAt,
  }) {
    return Batch(
      name: name ?? this.name,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'createdAt': createdAt,
    };
  }

  factory Batch.fromMap(Map<String, dynamic> map) {
    return Batch(
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Batch.fromJson(String source) => Batch.fromMap(json.decode(source));

  @override
  String toString() => 'Batch(name: $name, id: $id, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Batch &&
        other.name == name &&
        other.id == id &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ createdAt.hashCode;
}
