import 'package:coffy_shell/market/data/repository/market_repository.dart';
import 'package:coffy_shell/market/domain/entity/catalog_product.dart';

class GetCatalogProductsUseCase {
  final _marketRepository = MarketRepository();

  Future<List<CatalogProduct>> call() async {
    return await _marketRepository.getCatalogProducts();
  }
}
