import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffy_shell/market/data/model/catalog_product_model.dart';
import 'package:coffy_shell/market/domain/entity/catalog_product.dart';
import 'package:coffy_shell/market/domain/repository/i_market_repository.dart';

class MarketRepository implements IMarketRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<CatalogProduct>> getCatalogProducts() async {
    try {
      final snapshot = await _firestore.collection('market_products').get();
      
      if (snapshot.docs.isEmpty) {
        // If empty, we might want to populate it, but usually handled by a seed service
        return [];
      }

      return snapshot.docs.map((doc) {
        return CatalogProductModel.fromMap(doc.data(), doc.id).toEntity();
      }).toList();
    } catch (e) {
      print('MarketRepository Error: $e');
      return [];
    }
  }
}
