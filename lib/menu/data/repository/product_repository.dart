import 'package:coffy_shell/menu/data/model/product_model.dart';
import 'package:coffy_shell/menu/domain/entity/product.dart';
import 'package:coffy_shell/menu/domain/repository/i_product_repository.dart';

class ProductRepository implements IProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    final models = [
      ProductModel(name: 'Espresso', description: 'Strong and bold coffee', price: 2.5),
      ProductModel(name: 'Cappuccino', description: 'Espresso with steamed milk and foam', price: 3.0),
      ProductModel(name: 'Latte', description: 'Espresso with steamed milk', price: 3.5),
    ];

    return models.map((model) => model.toEntity()).toList();
  }
}
