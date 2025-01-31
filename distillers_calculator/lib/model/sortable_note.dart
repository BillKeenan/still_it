class SortableNote {
  int id;
  int batchId;
  String createdAt;

  SortableNote({
    required this.id,
    required this.batchId,
    required this.createdAt,
  });

  DateTime get createdAtDate {
    return DateTime.now();
  }
}
