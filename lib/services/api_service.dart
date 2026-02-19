import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hotel_model.dart';

class ApiService {
  final String baseUrl = "https://api.tudestinomx.com/api/hotel";
  final String apiToken = "1|gVKv3GSdJidkcPY17BJYcv4bUP4YW04ppgCgMghifc1bb99e";

  // Obtener lista (Ya lo tenías)
  Future<List<Hotel>> getHotels() async {
    // ... (Tu código existente de getHotels) ...
    // Solo asegúrate de copiarlo o mantenerlo aquí
    try {
      final response = await http.get(Uri.parse(baseUrl), headers: {
        'Authorization': 'Bearer $apiToken',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        final dynamic body = json.decode(response.body);
        List<dynamic> dataList = (body is Map && body.containsKey('data')) ? body['data'] : body;
        return dataList.map((json) => Hotel.fromJson(json)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // NUEVO: Obtener detalle por ID
  Future<Hotel> getHotelById(int id) async {
    final String url = "$baseUrl/$id"; // Ej: .../api/hotel/15

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $apiToken',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final dynamic body = json.decode(response.body);
        // A veces el detalle viene directo o dentro de "data"
        final dynamic data = (body is Map && body.containsKey('data')) ? body['data'] : body;

        return Hotel.fromJson(data);
      } else {
        throw Exception('Error al cargar detalle: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}