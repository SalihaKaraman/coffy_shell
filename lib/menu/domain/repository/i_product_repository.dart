import 'package:coffy_shell/menu/domain/entity/product.dart';

abstract class IProductRepository {
  Future<List<Product>> getProducts();
}
