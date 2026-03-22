class StocksModel {
  final String id;
  final String name;
  final String type;
  final double price;
  final double change;

  const StocksModel({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.change,
  });
}
