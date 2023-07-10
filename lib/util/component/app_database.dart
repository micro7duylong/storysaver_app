import 'package:com.qksoft.storysaverfacebook/models/product.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class AppDatabase {
  late final Box<Product> product;

  static Future<AppDatabase> instance() async {
    await Hive.initFlutter();

    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    Hive.registerAdapter(ProductAdapter());

    final productBox = await Hive.openBox<Product>('product');

    return AppDatabase._(productBox);
  }

  AppDatabase._(this.product);

  getPastProduct() {
    return product.get('past');
  }

  setPastProduct(Product value) async {
    await product.put('past', value);
  }
}
