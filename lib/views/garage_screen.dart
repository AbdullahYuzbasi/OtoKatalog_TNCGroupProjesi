import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';

class GarageScreen extends StatefulWidget {
  final List<Vehicle> vehicles;
  final Set<int> garageIds;

  const GarageScreen({
    super.key,
    required this.vehicles,
    required this.garageIds,
  });

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  @override
  Widget build(BuildContext context) {
    //Garajda olan araçları filtrelemek icin
    final garageVehicles = widget.vehicles
        .where((element) => widget.garageIds.contains(element.id))
        .toList();

    //Toplam fiyatı hesaplamak icin
    int totalPrice = 0;
    for (var vehicle in garageVehicles) {
      totalPrice += (vehicle.price ?? 0);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Garajım"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: garageVehicles.isEmpty
                  ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.directions_car_filled_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Garajınız boş",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: garageVehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = garageVehicles[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          //Araç Görseli
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                vehicle.image ?? "",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.car_crash, color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          //Araç Bilgileri kismi
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${vehicle.make} ${vehicle.model}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "\$${vehicle.price}",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Çıkarma Butonu
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            color: Colors.redAccent,
                            onPressed: () {
                              setState(() {
                                //Araç ID'sini garajdan çıkarmak icin
                                widget.garageIds.remove(vehicle.id);
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            if (garageVehicles.isNotEmpty) ...[
              const SizedBox(height: 8),

              //AÇILIR KAPANIR SİPARİŞ ÖZETİ
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: false,
                    iconColor: Colors.black,
                    collapsedIconColor: Colors.black,
                    title: const Text(
                      "Sipariş Özeti",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    subtitle: Text(
                      "${garageVehicles.length} Araç",
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    trailing: Text(
                      "\$$totalPrice",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue
                      ),
                    ),
                    children: [
                      //Yatay kaydırılabilir özet kartları
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: garageVehicles.length,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemBuilder: (context, index) {
                            final v = garageVehicles[index];
                            return Container(
                              width: 140,
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2)
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Mini Görsel alani
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      v.image ?? "",
                                      height: 60,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_,__,___) => const Icon(Icons.car_crash),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Marka - Model
                                  Text(
                                      "${v.make} ${v.model}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                      v.specs?.engine ?? "Belirtilmemiş",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 10, color: Colors.grey.shade600)
                                  ),
                                  const Spacer(),
                                  // Fiyat
                                  Text(
                                      "\$${v.price}",
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              //EN ALTTAKİ  SATIN AL BUTONU
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Satın alma işlemi başlatıldı!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                    "Satın Al (\$$totalPrice)",
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}