import 'dart:convert';

class Batch {
  int? id;
  String? name;
  String? product;

  Batch.empty();

  Batch(
    this.id,
    this.name,
    this.product,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'product': product,
    };
  }

  Batch.fromMap(Map<dynamic, dynamic> map) {
    id = map['id']?.toInt();
    name = map["title"].toString();
    product = map["title"].toString();
  }

  String toJson() => json.encode(toMap());

  factory Batch.fromJson(String source) => Batch.fromMap(json.decode(source));

  @override
  String toString() => 'Batch(id: $id, name: $name, product: $product)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Batch &&
        other.id == id &&
        other.name == name &&
        other.product == product;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ product.hashCode;

  Batch copyWith({
    int? id,
    String? name,
    String? product,
  }) {
    return Batch(
      id ?? this.id,
      name ?? this.name,
      product ?? this.product,
    );
  }
}
