class SortableNote {
  int id;
  int batchId;
  String createdAt;

  SortableNote({
    required this.id,
    required this.batchId,
    required this.createdAt,
  });

  String shortCreatedDateTime() {
    return "not set";
  }

  int get createdAtDate {
    return 0;
  }
}
