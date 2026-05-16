import 'package:flutter/material.dart';
import '../components/vehicle_card.dart';
import '../models/vehicle_model.dart';
import '../services/api_service.dart';
import 'garage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Durum değişkenlerimiz
  bool isLoading = false;
  List<Vehicle> allVehicles = []; // Product yerine Vehicle kullanıyoruz
  List<Vehicle> filteredVehicle = [];
  ApiService apiService = ApiService();
  String errorMessage = "";
  Set<int> garageIds = {};

  @override
  void initState() {
    super.initState();
    //verileri çekme fonksiyonunu
    loadVehicles();
  }

  //Verileri API'den çeken asenkron fonksiyon
  Future<void> loadVehicles() async {
    try {
      setState(() {
        isLoading = true;
      });

      //API servisimiz
      final vehicleResponse = await apiService.fetchVehicles();

      setState(() {
        allVehicles = vehicleResponse.data ?? [];
        filteredVehicle = allVehicles;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Araçlar yüklenirken hata oluştu: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Üst Kısım: Başlık ve Garaj (Sepet) İkonu
              Row(
                children: [
                  const Text(
                    'Keşfet',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.directions_car_outlined),
                    iconSize: 32,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GarageScreen(
                            vehicles: allVehicles,
                            garageIds: garageIds,
                          ),
                        ),
                      ).then((value) {
                        //ana sayfayı yenilemek için
                        setState(() {});
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // 2. Arama Çubuğu
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Araç ara...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onChanged: (value) {
                    setState(() {
                      filteredVehicle = allVehicles.where((vehicle){
                        final aramaMetni = value.toLowerCase();
                        final marka = (vehicle.make ?? '').toLowerCase();
                        final model = (vehicle.model ?? '').toLowerCase();
                        return marka.contains(aramaMetni) || model.contains(aramaMetni);
                      }).toList();
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),

              // 3. Banner Görseli
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://images.unsplash.com/photo-1495435229349-e86db7bfa013?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Y2FyJTIwZ2FyYWdlfGVufDB8fDB8fHww",
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 100,
                    color: Colors.grey[300],
                    child: const Center(child: Text("Banner Yüklenemedi")),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              //4. Hata mesajı varsa diye
              if (errorMessage.isNotEmpty)
                Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),

              //5. Araç Listesi (GridView)
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Yan yana 2 kart
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7, // Kartların en-boy oranı
                  ),
                  itemCount: filteredVehicle.length,
                  itemBuilder: (context, index) {
                    final vehicle = filteredVehicle[index];
                    return VehicleCard(
                        vehicle: vehicle,
                        garageIds: garageIds,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}