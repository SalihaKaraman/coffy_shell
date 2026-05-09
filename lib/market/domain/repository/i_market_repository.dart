import 'package:coffy_shell/market/domain/entity/catalog_product.dart';

abstract class IMarketRepository {
  Future<List<CatalogProduct>> getCatalogProducts();
}
