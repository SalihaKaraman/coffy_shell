import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffy_shell/models/product.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get products from Firestore
  Stream<List<Product>> getProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromMap(doc.data(), doc.id)).toList();
    });
  }

  // Populate Firestore with initial dummy data if empty
  Future<void> populateDummyData() async {
    final productsCollection = _firestore.collection('products');
    
    final snapshot = await productsCollection.limit(1).get();
    if (snapshot.docs.isEmpty) {
      final List<Product> dummyProducts = [
        Product(
          id: '',
          name: 'Artisanal Latte',
          description: 'Özel kavrulmuş çekirdekler ve ipeksi süt köpüğü.',
          price: 65.0,
          imageUrl: '',
          category: 'Kahve',
        ),
        Product(
          id: '',
          name: 'V60 Pour Over',
          description: 'Taze demlenmiş, meyvemsi notalara sahip filtre kahve.',
          price: 55.0,
          imageUrl: '',
          category: 'Kahve',
        ),
        Product(
          id: '',
          name: 'Limonlu Cheesecake',
          description: 'Günlük taze, yoğun limon aromalı enfes tatlı.',
          price: 85.0,
          imageUrl: '',
          category: 'Tatlı',
        ),
      ];

      for (var product in dummyProducts) {
        await productsCollection.add(product.toMap());
      }
    }
  }
}
