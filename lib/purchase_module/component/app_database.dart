import 'package:com.qksoft.storysaverfacebook/models/product.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class AppDatabase {
  late final Box<Product> product;

  static Future<AppDatabase> instance() async {
    final Box<Product> pd = Hive.box('product');
    return AppDatabase._(pd);
  }

  AppDatabase._(this.product);

  getPastProduct() {
    return product.get('past');
  }

  setPastProduct(Product value) async {
    await product.put('past', value);
  }
}
