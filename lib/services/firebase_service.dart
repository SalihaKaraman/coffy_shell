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
    try {
      final productsCollection = _firestore.collection('products');
      
      final snapshot = await productsCollection.get();
      if (snapshot.docs.length < 11) {
        print('Firebase: Ürün sayısı yetersiz (${snapshot.docs.length}), güncelleniyor...');
        
        // Batch delete to be more efficient
        final batch = _firestore.batch();
        for (var doc in snapshot.docs) {
          batch.delete(doc.reference);
        }
        await batch.commit();
        
        final List<Product> dummyProducts = [
          // Kahve
          Product(
            id: '',
            name: 'Artisanal Latte',
            description: 'Özel kavrulmuş çekirdekler ve ipeksi süt köpüğü.',
            price: 65.0,
            imageUrl: 'https://images.unsplash.com/photo-1541167760496-162955ed8a9f?w=500',
            category: 'Kahve',
          ),
          Product(
            id: '',
            name: 'V60 Pour Over',
            description: 'Taze demlenmiş, meyvemsi notalara sahip filtre kahve.',
            price: 55.0,
            imageUrl: 'https://images.unsplash.com/photo-1544787210-282aa748283b?w=500',
            category: 'Kahve',
          ),
          Product(
            id: '',
            name: 'Cortado',
            description: 'Eşit miktarda espresso ve süt ile yoğun kıvam.',
            price: 60.0,
            imageUrl: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=500',
            category: 'Kahve',
          ),
          Product(
            id: '',
            name: 'Flat White',
            description: 'Yoğun espresso ve mikro köpüklü sütün uyumu.',
            price: 70.0,
            imageUrl: 'https://images.unsplash.com/photo-1577968897966-3d4325b36b61?w=500',
            category: 'Kahve',
          ),

          // Tatlı
          Product(
            id: '',
            name: 'Limonlu Cheesecake',
            description: 'Günlük taze, yoğun limon aromalı enfes tatlı.',
            price: 85.0,
            imageUrl: 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=500',
            category: 'Tatlı',
          ),
          Product(
            id: '',
            name: 'Çikolatalı Brownie',
            description: 'Bol çikolatalı, içi yumuşak cevizli brownie.',
            price: 75.0,
            imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=500',
            category: 'Tatlı',
          ),
          Product(
            id: '',
            name: 'Tiramisu',
            description: 'Klasik İtalyan tarifiyle hazırlanmış hafif tatlı.',
            price: 90.0,
            imageUrl: 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=500',
            category: 'Tatlı',
          ),

          // Çay
          Product(
            id: '',
            name: 'Matcha Latte',
            description: 'Japonya\'dan gelen premium matcha ve süt.',
            price: 80.0,
            imageUrl: 'https://images.unsplash.com/photo-1515823064-d6e0c04616a7?w=500',
            category: 'Çay',
          ),
          Product(
            id: '',
            name: 'Hibiscus Tea',
            description: 'C vitamini deposu, ferahlatıcı kırmızı çay.',
            price: 50.0,
            imageUrl: 'https://images.unsplash.com/photo-1558160074-4d7d8bdf4256?w=500',
            category: 'Çay',
          ),

          // Soğuk
          Product(
            id: '',
            name: 'Cold Brew',
            description: '12 saat soğuk demlenmiş, düşük asiditeli kahve.',
            price: 75.0,
            imageUrl: 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=500',
            category: 'Soğuk',
          ),
          Product(
            id: '',
            name: 'Çilekli Limonata',
            description: 'Ev yapımı taze limonata ve gerçek çilekler.',
            price: 65.0,
            imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=500',
            category: 'Soğuk',
          ),
        ];

        final addBatch = _firestore.batch();
        for (var product in dummyProducts) {
          addBatch.set(productsCollection.doc(), product.toMap());
        }
        await addBatch.commit();
        print('Firebase: 11 ürün başarıyla güncellendi.');
      } else {
        print('Firebase: Ürünler zaten güncel.');
      }
    } catch (e) {
      print('Firebase Error: $e');
    }
  }
}
