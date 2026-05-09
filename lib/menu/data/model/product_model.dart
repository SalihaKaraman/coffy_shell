import 'package:coffy_shell/menu/domain/entity/product.dart';

class ProductModel {
  final String? name;
  final String? description;
  final double? price;

  ProductModel({this.name, this.description, this.price});

  Product toEntity() {
    return Product(name: name, description: description, price: price);
  }
}
