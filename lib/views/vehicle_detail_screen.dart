import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';

class VehicleDetailScreen extends StatefulWidget {
  final Vehicle vehicle;
  final Set<int> garageIds;

  const VehicleDetailScreen({
    super.key,
    required this.vehicle,
    required this.garageIds,
  });

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    //Araç zaten garajda mı kontrol edelir
    bool isInGarage = widget.garageIds.contains(widget.vehicle.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Geri"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      //Uzun açıklama ve özellikler icin scroll kismi
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //1. Büyük Araç Görseli
            Image.network(
              widget.vehicle.image ?? "",
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 350,
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.car_crash, size: 50, color: Colors.grey)),
              ),
            ),

            //2. Metin Alanı ve Detaylar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.vehicle.make} ${widget.vehicle.model}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    "${widget.vehicle.year} Model • ${widget.vehicle.specs?.fuelType ?? 'Bilinmiyor'}",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "Açıklama",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    widget.vehicle.description ?? "Bu araç için açıklama bulunmamaktadır.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                      height: 1.5, // Satır arası boşluk
                    ),
                  ),
                  const SizedBox(height: 24),

                  if (widget.vehicle.specs != null) ...[
                    const Text(
                      "Teknik Özellikler",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    _buildSpecRow("Motor", widget.vehicle.specs?.engine),
                    _buildSpecRow("Vites", widget.vehicle.specs?.transmission),
                    if (widget.vehicle.specs?.horsepower != null)
                      _buildSpecRow("Beygir Gücü", widget.vehicle.specs?.horsepower),
                    if (widget.vehicle.specs?.s060mph != null)
                      _buildSpecRow("0-60 mph", widget.vehicle.specs?.s060mph),
                    const SizedBox(height: 30),
                  ],

                  //3. Garaja Ekle Butonu
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (isInGarage) {
                          // Zaten garajdaysa çıkarir
                          widget.garageIds.remove(widget.vehicle.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Araç garajdan çıkarıldı.")),
                          );
                        } else {
                          //Garajda yoksa ekler
                          widget.garageIds.add(widget.vehicle.id ?? 0);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Araç garaja eklendi!")),
                          );
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isInGarage ? Colors.red.shade800 : Colors.black,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isInGarage
                          ? "Garajdan Çıkar"
                          : "Garaja Ekle (\$${widget.vehicle.price})",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(String title, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$title:",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade700),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}