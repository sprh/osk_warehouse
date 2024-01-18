class Product {
  final String id;
  final String name;
  final String description;
  final int? count;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    this.count,
  });
}
