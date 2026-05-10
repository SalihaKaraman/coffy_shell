# CoffyShell ☕

CoffyShell, kahve tutkunları için özel olarak tasarlanmış, modern ve kullanıcı dostu bir kahve sipariş uygulamasıdır. Kullanıcıların damak tadına hitap eden ürünleri keşfetmelerini, sipariş vermelerini ve yapay zeka desteğiyle modlarına göre en uygun kahveyi bulmalarını sağlar.

## 🚀 Temel Özellikler

- **Gelişmiş Kahve Siparişi:** Menüden dilediğiniz kahveyi seçin ve hızlıca sepetinize ekleyin.
- **Yapay Zeka Destekli Öneriler:** O anki ruh halinizi (Yorgun, Sakin, Odaklanmış vb.) seçin, CoffyShell size en uygun kahveyi önersin.
- **Favoriler:** Sevdiğiniz kahveleri favorilerinize ekleyin ve onlara her an kolayca ulaşın.
- **Coffy Market:** Sadece içecek değil, kahve çekirdekleri ve ekipmanları da keşfedin.
- **Sadakat Programı:** Her siparişinizde puan kazanın ve ücretsiz kahve fırsatlarını yakalayın.

## 📱 Ekran Görüntüleri

| Hoş Geldiniz | Anasayfa | Menü |
| :---: | :---: | :---: |
| ![Welcome](ScreenShots/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-05-10%20at%2013.09.09.png) | ![Home](ScreenShots/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-05-10%20at%2013.09.13.png) | ![Menu](ScreenShots/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-05-10%20at%2013.09.21.png) |

| Şubelerimiz | Market | AI Asistanı |
| :---: | :---: | :---: |
| ![Branches](ScreenShots/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-05-10%20at%2013.09.36.png) | ![Market](ScreenShots/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-05-10%20at%2013.09.40.png) | ![AI Assistant](ScreenShots/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-05-10%20at%2013.09.44.png) |

| Sepetim | Hesabım | Favorilerim |
| :---: | :---: | :---: |
| ![Cart](ScreenShots/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-05-10%20at%2013.10.06.png) | ![Profile](ScreenShots/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-05-10%20at%2013.10.18.png) | ![Favorites](ScreenShots/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-05-10%20at%2013.10.49.png) |

| Sadakat Kartı |
| :---: |
| ![Loyalty](ScreenShots/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-05-10%20at%2013.10.56.png) |

## 🛠 Kullanılan Teknolojiler

- **Framework:** [Flutter](https://flutter.dev/) (Dart)
- **Backend & Database:** [Firebase](https://firebase.google.com/) (Cloud Firestore)
- **State Management:** [Provider](https://pub.dev/packages/provider)
- **Tasarım:** [Stitch](https://stitch.withgoogle.com/), Custom Theme & [Google Fonts](https://fonts.google.com/) (Playfair Display, Outfit)
- **Yapay Zeka:** Mood-based recommendation logic (Built with AI patterns)

## 🔥 Firebase Firestore Veri Yapısı

Uygulama, verileri gerçek zamanlı olarak Firebase Firestore üzerinden çeker. Kullanılan temel koleksiyonlar ve veri yapıları şöyledir:

### 1. `products` (Menü Ürünleri)
Uygulamanın ana menüsünde listelenen kahve ve tatlılar bu koleksiyondan gelir.
- **Alanlar:** `name`, `description`, `price`, `imageUrl`, `category` (Kahve, Tatlı, Çay, Soğuk).

### 2. `market_products` (Market Ürünleri)
Market sekmesinde satılan çekirdek kahve ve ekipmanları içerir.
- **Alanlar:** `name`, `description`, `price`, `imageUrl`, `category`, `isFeatured`.

### 3. `branches` (Şubelerimiz)
Harita üzerinde gösterilen kafe şubelerinin bilgilerini tutar.
- **Alanlar:** `name`, `address`, `latitude`, `longitude`, `phoneNumber`, `openingHours`, `rating`.

**Veri Çekme Yöntemi:**
Uygulama, Firestore `snapshots()` metodunu kullanarak verileri bir **Stream** olarak dinler. Bu sayede veritabanında yapılan herhangi bir değişiklik (fiyat güncellemesi, yeni ürün ekleme vb.) uygulamaya anında yansır.

## 📂 Proje Yapısı

```text
lib/
├── ai/                 # Yapay zeka modülü (Mood selection & recommendations)
├── branches/           # Şube yönetimi ve Google Maps entegrasyonu
├── market/             # Market ürünleri ve ekipman kataloğu
├── models/             # Veri modelleri (Product, Order vb.)
├── providers/          # State management sınıfları (Cart, Favorites, Nav)
├── screens/            # Ana uygulama ekranları
├── services/           # Firebase ve API servisleri
├── theme/              # Renk paleti ve tema yapılandırması
└── widgets/            # Tekrar kullanılabilir UI bileşenleri
```

## 🎓 Etkinlik ve Workshop

Bu proje, **gdgAdana** tarafından düzenlenen **Build with AI 2026** kapsamında, **Turkish Technology** sponsorluğundaki workshop etkinliği için özel olarak geliştirilmiştir. Etkinlik boyunca Flutter ve yapay zeka entegrasyonu üzerine pratik uygulamalar gerçekleştirilmiştir.

---
*Geliştiren: Saliha Karaman & Team*
