import 'package:coffy_shell/market/domain/entity/catalog_product.dart';

class CatalogProductModel {
  final String? name;

  CatalogProductModel({this.name});

  CatalogProduct toEntity() {
    return CatalogProduct(name: name);
  }
}
