class PackingList {
  final int id;
  final String name;

  PackingList({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'PackingList{id: $id, name: $name}';
  }
}