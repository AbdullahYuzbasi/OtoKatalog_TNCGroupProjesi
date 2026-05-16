import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vehicle_model.dart';

class ApiService {

  Future<VehicleResponse> fetchVehicles() async {
    final response = await http.get(
      Uri.parse("https://wantapi.com/vehicles.php"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // JSON'ı cozdukten sonra kendi modelimizin fromJson metoduyla donusturecegim
      return VehicleResponse.fromJson(data);
    } else {
      throw Exception("Araçlar yüklenirken hata oluştu.");
    }
  }
}