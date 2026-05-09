import 'package:coffy_shell/menu/data/repository/product_repository.dart';
import 'package:coffy_shell/menu/domain/entity/product.dart';

class GetProductsUseCase {
  final _productRepository = ProductRepository();

  Future<List<Product>> call() async {
    return await _productRepository.getProducts();
  }
}
