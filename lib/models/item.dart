class Item {
  final String id;
  final String title;
  final String createdAt;

  const Item({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'].toString(),
      title: (json['title'] as String?) ?? 'Untitled',
      createdAt: (json['createdAt'] as String?) ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'createdAt': createdAt,
      };
}
