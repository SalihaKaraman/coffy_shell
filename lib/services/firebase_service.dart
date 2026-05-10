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
      // Products collection
      final productsCollection = _firestore.collection('products');
      final snapshot = await productsCollection.get();
      if (snapshot.docs.length < 11) {
        print('Firebase: Ürün sayısı yetersiz (${snapshot.docs.length}), güncelleniyor...');
        final batch = _firestore.batch();
        for (var doc in snapshot.docs) batch.delete(doc.reference);
        await batch.commit();
        
        final List<Product> dummyProducts = [
          // ... (existing dummy products)
          Product(id: '', name: 'Artisanal Latte', description: 'Özel kavrulmuş çekirdekler ve ipeksi süt köpüğü.', price: 65.0, imageUrl: 'https://images.unsplash.com/photo-1541167760496-162955ed8a9f?w=500', category: 'Kahve'),
          Product(id: '', name: 'V60 Pour Over', description: 'Taze demlenmiş, meyvemsi notalara sahip filtre kahve.', price: 55.0, imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=500', category: 'Kahve'),
          Product(id: '', name: 'Cortado', description: 'Eşit miktarda espresso ve süt ile yoğun kıvam.', price: 60.0, imageUrl: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=500', category: 'Kahve'),
          Product(id: '', name: 'Flat White', description: 'Yoğun espresso ve mikro köpüklü sütün uyumu.', price: 70.0, imageUrl: 'https://images.unsplash.com/photo-1577968897966-3d4325b36b61?w=500', category: 'Kahve'),
          Product(id: '', name: 'Limonlu Cheesecake', description: 'Günlük taze, yoğun limon aromalı enfes tatlı.', price: 85.0, imageUrl: 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=500', category: 'Tatlı'),
          Product(id: '', name: 'Çikolatalı Brownie', description: 'Bol çikolatalı, içi yumuşak cevizli brownie.', price: 75.0, imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=500', category: 'Tatlı'),
          Product(id: '', name: 'Tiramisu', description: 'Klasik İtalyan tarifiyle hazırlanmış hafif tatlı.', price: 90.0, imageUrl: 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=500', category: 'Tatlı'),
          Product(id: '', name: 'Matcha Latte', description: 'Japonya\'dan gelen premium matcha ve süt.', price: 80.0, imageUrl: 'https://images.unsplash.com/photo-1515823064-d6e0c04616a7?w=500', category: 'Çay'),
          Product(id: '', name: 'Hibiscus Tea', description: 'C vitamini deposu, ferahlatıcı kırmızı çay.', price: 50.0, imageUrl: 'https://images.unsplash.com/photo-1558160074-4d7d8bdf4256?w=500', category: 'Çay'),
          Product(id: '', name: 'Cold Brew', description: '12 saat soğuk demlenmiş, düşük asiditeli kahve.', price: 75.0, imageUrl: 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=500', category: 'Soğuk'),
          Product(id: '', name: 'Double Espresso', description: 'Güne başlamak için saf ve yoğun kafein gücü.', price: 50.0, imageUrl: 'https://images.unsplash.com/photo-1510707577719-af5c1aa550df?w=500', category: 'Kahve'),
          Product(id: '', name: 'Iced Americano', description: 'Serinletici ve sert, taze demlenmiş espresso.', price: 65.0, imageUrl: 'https://images.unsplash.com/photo-1551046710-23b0d2c2869b?w=500', category: 'Soğuk'),
        ];

        final addBatch = _firestore.batch();
        for (var product in dummyProducts) addBatch.set(productsCollection.doc(), product.toMap());
        await addBatch.commit();
      }

      // Market Products collection
      final marketCollection = _firestore.collection('market_products');
      final marketSnapshot = await marketCollection.get();
      if (marketSnapshot.docs.length < 6) {
        print('Firebase: Market ürünleri güncelleniyor...');
        final marketBatch = _firestore.batch();
        
        // Clean old data if exists
        for (var doc in marketSnapshot.docs) marketBatch.delete(doc.reference);
        
        final List<Map<String, dynamic>> dummyMarketProducts = [
          {
            'name': 'L\'Artisan Blend (250g)',
            'description': 'Özel harman taze kavrulmuş kahve çekirdekleri.',
            'price': 420.0,
            'imageUrl': 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=800',
            'category': 'Kahve Çekirdeği',
            'isFeatured': false,
          },
          {
            'name': 'Ceramic V60 Dripper',
            'description': 'Mükemmel demleme için seramik V60.',
            'price': 850.0,
            'imageUrl': 'https://images.unsplash.com/photo-1544666668-d0b471206f48?w=800',
            'category': 'Demleme',
            'isFeatured': true,
          },
          {
            'name': 'Pro Gooseneck Su Isıtıcı',
            'description': 'Hassas döküm için özel tasarım, ahşap detaylı.',
            'price': 3450.0,
            'imageUrl': 'https://images.unsplash.com/photo-1577935700721-66708b538743?w=800',
            'category': 'Premium Seri',
            'isFeatured': false,
          },
          {
            'name': 'El Yapımı Seramik Kupa',
            'description': 'Size özel el yapımı tasarım kupa.',
            'price': 550.0,
            'imageUrl': 'https://images.unsplash.com/photo-1514228742587-6b1558fbed20?w=800',
            'category': 'Aksesuar',
            'isFeatured': false,
          },
          {
            'name': 'V60 Filtre Kağıdı (100 Adet)',
            'description': 'V60 demlemeleriniz için kaliteli filtre kağıdı.',
            'price': 195.0,
            'imageUrl': 'https://images.unsplash.com/photo-1580915411954-282cb1b0d780?w=800',
            'category': 'Demleme',
            'isFeatured': false,
          },
          {
            'name': 'Etiyopya Yirgacheffe',
            'description': 'Çiçeksi ve narenciye notalı özel çekirdek.',
            'price': 480.0,
            'imageUrl': 'https://images.unsplash.com/photo-1611854779393-1b2da9d400fe?w=800',
            'category': 'Kahve Çekirdeği',
            'isFeatured': true,
          },
        ];

        for (var product in dummyMarketProducts) {
          marketBatch.set(marketCollection.doc(), product);
        }
        await marketBatch.commit();
      }

      // Branches collection
      final branchesCollection = _firestore.collection('branches');
      final branchesSnapshot = await branchesCollection.get();
      if (branchesSnapshot.docs.isEmpty) {
        print('Firebase: Şube verileri yükleniyor...');
        final branchesBatch = _firestore.batch();

        final List<Map<String, dynamic>> dummyBranches = [
          {
            'name': 'L\'Artisan - Nişantaşı',
            'address': 'Teşvikiye, Abdi İpekçi Cd. No:12, 34367 Şişli/İstanbul',
            'latitude': 41.0503,
            'longitude': 28.9918,
            'phoneNumber': '0212 234 56 78',
            'openingHours': '08:00 - 22:00',
            'rating': 4.8,
          },
          {
            'name': 'L\'Artisan - Bebek',
            'address': 'Bebek, Cevdet Paşa Cd. No:45, 34342 Beşiktaş/İstanbul',
            'latitude': 41.0762,
            'longitude': 29.0438,
            'phoneNumber': '0212 345 67 89',
            'openingHours': '07:30 - 23:00',
            'rating': 4.9,
          },
          {
            'name': 'L\'Artisan - Kadıköy Moda',
            'address': 'Caferağa, Moda Cd. No:88, 34710 Kadıköy/İstanbul',
            'latitude': 40.9847,
            'longitude': 29.0256,
            'phoneNumber': '0216 456 78 90',
            'openingHours': '09:00 - 23:30',
            'rating': 4.7,
          },
        ];

        for (var branch in dummyBranches) {
          branchesBatch.set(branchesCollection.doc(), branch);
        }
        await branchesBatch.commit();
      }
    } catch (e) {
      print('Firebase Error: $e');
    }
  }
}
