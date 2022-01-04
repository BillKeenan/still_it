import 'dart:convert';

class Batch {
  String? name;
  String? product;

  Batch();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'product': product,
    };
  }

  Batch.fromMap(Map<dynamic, dynamic> map) {
    name = map["title"].toString();
    product = map["title"].toString();
  }

  String toJson() => json.encode(toMap());

  factory Batch.fromJson(String source) => Batch.fromMap(json.decode(source));

  @override
  String toString() => 'batch(name: $name, product: $product)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Batch && other.name == name && other.product == product;
  }

  @override
  int get hashCode => name.hashCode ^ product.hashCode;
}
