import 'package:hive_flutter/hive_flutter.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  String productID;
  @HiveField(1)
  DateTime expireDate;
  Product({
    required this.expireDate,
    required this.productID,
  });
}
