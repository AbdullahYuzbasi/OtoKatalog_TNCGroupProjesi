# 🚗 OtoKatalog - Dinamik Araç Kataloğu Uygulaması

![Flutter](https://img.shields.io/badge/Flutter-3.38.0--0.1.pre-blue?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.10.0-blue?style=for-the-badge&logo=dart)

## 📖 Proje Hakkında
Bu proje, Flutter kullanılarak geliştirilmiş modern ve dinamik bir araç kataloğu simülasyonudur. Uygulama, internet üzerinden araç verilerini çeker, kullanıcıların bu araçları anlık olarak filtrelemesine, detaylı teknik özelliklerini incelemesine ve beğendikleri araçları kişisel bir "Garaj" (sepet) ortamına eklemelerine olanak tanır. Garaj ekranında kullanıcılar, seçtikleri araçların fiyatlarını ve toplam sipariş özetini interaktif bir arayüzle görebilirler.

## Kullanılan Teknolojiler ve Sürümler
* **Flutter Sürümü:** 3.38.0-0.1.pre
* **Dart Sürümü:** 3.10.0
* **Mimari:** Modüler yapı (Models, Views, Services, Components)

## 🔗 API Seçimi: Neden WantAPI?
Bu projede veri kaynağı olarak **WantAPI**'nin ücretsiz araç (vehicle) endpoint'i kullanılmıştır. WantAPI'nin tercih edilme sebebi; sunduğu JSON yapısının (marka, model, fiyat, yüksek çözünürlüklü resim URL'leri ve motor, beygir gücü gibi alt özellikler) gerçek dünya e-ticaret ve katalog senaryolarını simüle etmek uygun olmasıdır. Bu veri seti sayesinde arayüzde çok daha detaylı ve gerçekçi bileşenler kurgulanabilmiştir(PROJE KAPSAMINDA).

## 🏗️ Kodda Kullanılan Temel Yapılar
* **`GridView.builder`:** Ana sayfadaki araç kartlarının (VehicleCard) yan yana ve ekran boyutuna duyarlı bir ızgara düzeninde listelenmesi için kullanıldı.
* **`ListView.builder` (Dikey ve Yatay):** Garaj ekranındaki araç listesini dikey olarak sıralamak ve sipariş özetindeki mini araç kartlarını yatay olarak kaydırılabilir şekilde sunmak için uygulandı.
* **Dinamik Arama (Search):** `TextField` widget'ının `onChanged` metodu kullanılarak, kullanıcının girdiği metne göre `filteredVehicles` listesi anlık olarak güncellendi.
* **`ExpansionTile`:** Garaj sayfasında, kullanıcının isteğine bağlı olarak açılıp kapanabilen ve arayüzü kalabalıklaştırmayan "Sipariş Özeti" modülü için kullanıldı.
* **Route Arguments (Veri Taşıma):** `Navigator.push` ile sayfalar arası geçiş yapılırken `Vehicle` modeli ve `garageIds` seti argüman olarak taşındı.
* **`setState` (Durum Yönetimi):** Arama filtrelemesi yapmak ve garaja araç ekleyip/çıkarmak (sepet simülasyonu) gibi anlık arayüz güncellemeleri için temel durum yönetimi olarak kullanıldı.

## 🚀 Çalıştırma Adımları

Projeyi kendi ortamınızda çalıştırmak için aşağıdaki adımları sırayla izleyin:

**1. Projeyi Klonlayın**
Terminal veya komut satırını açarak projeyi bilgisayarınıza indirin (Linkteki kullanıcı adını kendi GitHub adınızla değiştirin):
```bash
git clone [https://github.com/KULLANICI_ADIN/TNCGroup.git](https://github.com/KULLANICI_ADIN/TNCGroup.git)
